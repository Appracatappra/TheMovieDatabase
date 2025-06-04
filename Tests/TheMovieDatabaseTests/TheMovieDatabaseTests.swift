import Testing
import UrlUtilities
@testable import TheMovieDatabase

// Set parameters
let apiKey: String = "YOUR_API_KEY"
let username = "YOUR_USSERNAME"
let password = "YOUR_PASSWORD"

@Test func urlBuilder() async throws {
    // Set api key
    TMDConfiguration.setApiKey(apiKey)
    
    let endpoint = URLBuilder("https://login")
        .addParameter(name: "username", value: "jdoe")
        .addParameter(name: "password", value: "pass123")
        .urlString
    
    let validation = "https://login?api_key=\(TMDConfiguration.apiKey)&username=jdoe&password=pass123"
    
    #expect(endpoint == validation)
}

@Test func testGuestLogin() async throws {
    // Set api key
    TMDConfiguration.setApiKey(apiKey)
    
    let success = await TMDEndpoint.loginGuest()
    
    #expect(success == true)
}

@Test func testUserLogin() async throws {
    // Set api key
    TMDConfiguration.setApiKey(apiKey)
    
    let success = await TMDEndpoint.loginUser(username: username, password: password)
    
    guard success else {
        Issue.record("Login failed")
        return
    }
    
    #expect(TMDEndpoint.account.username == "KevKM")
}

@Test func testDiscoverMovies() async throws {
    // Set api key
    TMDConfiguration.setApiKey(apiKey)
    
    let success = await TMDEndpoint.loginGuest()
    
    guard success else {
        Issue.record("Login failed")
        return
    }
    
    // Assemble query
    let certifications = TMDQueryCertifications()
    let dates = TMDQueryDates()
    let votes = TMDQueryVotes()
    let with = TMDQueryWith(genres:"14")
    let without = TMDQueryWithout()
    let query = TMDMovieQuery(certifications: certifications, dates: dates, sortBy: .originalTitleAsc, votes: votes, with: with, without: without, year: "1992")
    
    let movies = await TMDMovies.discover(query: query)
    
    guard let movies else {
        Issue.record("Query failed")
        return
    }
    
    #expect(movies.totalResults == 255)
}
