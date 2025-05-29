import Testing
@testable import TheMovieDatabase

// Set parameters
let apiKey: String = "YOUR_API_KEY"
let username = "YOUR_USSERNAME"
let password = "YOUR_PASSWORD"

@Test func urlBuilder() async throws {
    // Set api key
    TMDConfiguration.apiKey = apiKey
    
    let endpoint = URLBuilder("https://login")
        .addParameter(name: "username", value: "jdoe")
        .addParameter(name: "password", value: "pass123")
        .urlString
    
    let validation = "https://login?api_key=\(TMDConfiguration.apiKey)&username=jdoe&password=pass123"
    
    #expect(endpoint == validation)
}

@Test func testGuestLogin() async throws {
    // Set api key
    TMDConfiguration.apiKey = apiKey
    
    let success = await TMDEndpoint.loginGuest()
    
    #expect(success == true)
}

@Test func testUserLogin() async throws {
    // Set api key
    TMDConfiguration.apiKey = apiKey
    
    let success = await TMDEndpoint.loginUser(username: username, password: password)
    
    guard success else {
        Issue.record("Login failed")
        return
    }
    
    #expect(TMDEndpoint.account.username == "KevKM")
}
