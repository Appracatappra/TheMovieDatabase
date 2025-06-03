//
//  TMDEndpoint.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/22/25.
//

import Foundation
import LogManager

/// Low-leve backend API calls for Accounts in The Movie Database.
open class TMDEndpoint: Codable, @unchecked Sendable {
    
    // MARK: - Static Properties
    /// Holds the currently open session ID used to communicate with The Movie Database.
    nonisolated(unsafe) public static var sessionID: String = ""
    
    /// Holds the currently logged in user account.
    nonisolated(unsafe) public static var account: TMDAccount = TMDAccount()
    
    // MARK: - Static Computed Properties
    /// Gets the ID of the currently logged in user account.
    public static var accountID: Int {
        return account.id
    }
    
    // MARK: - Static Functions
    /// Logs a user into The Movie Database using a username and password.
    /// - Parameters:
    ///   - username: The user's username.
    ///   - password: The user's password.
    /// - Returns: Returns `true` if successfully logged in using the user's credentials, else returns `false` on eror.
    public static func loginUser(username:String, password:String) async -> Bool {
        
        // Clear any existing session IDs
        sessionID = ""
        
        // Get the login token.
        let login = await TMDRequestToken.getLoginToken(username: username, password: password)
        
        // Did we get a token?
        guard let login else {
            // No, log and return failure.
            Debug.log("Request token not found")
            return false
        }
        
        // Get the session for the login.
        let session = await TMDSession.getNewSession(requestToken: login.requestToken)
        
        // Did we get a session?
        guard let session else {
            // No, log and return failure.
            Debug.log("Session not found")
            return false
        }
        
        // Did we get a valid session?
        guard session.success else {
            // No, log and return failure.
            Debug.log("An invalid session was returned")
            return false
        }
        
        // Save the returned session ID.
        sessionID = session.sessionID
        
        // Get the user account for this session ID.
        let userAccount = await TMDAccount.getAccount(sessionID: sessionID)
        
        // Did we get the account?
        guard let userAccount else {
            // No, log and return failure.
            Debug.log("Account not found")
            return false
        }
        
        // Save the current user
        account = userAccount
        
        // Return the success status.
        return true
    }
    
    /// Logs a Guest into The Movie Database.
    /// - Returns: Returns `true` if the guest account was logged in successfully, else returns `false`.
    public static func loginGuest() async -> Bool {
        
        // Get a guest session.
        let session = await TMDGuestSession.getNewSession()
        
        // Did we get a session?
        guard let session else {
            // No, log and return failure.
            Debug.log("Session not found")
            return false
        }
        
        // Did we get a valid session?
        guard session.success else {
            // No, log and return failure.
            Debug.log("An invalid session was returned")
            return false
        }
        
        // Save the returned session ID.
        sessionID = session.guestSessionID
        
        // Set the user account to guest.
        account = TMDAccount()
        
        // Return the success status.
        return true
    }
    
    /// Attempts to log the current user out of The Movie Database.
    /// - Returns: Returns `true` if successful else returns `false`.
    public static func logout() async -> Bool {
        
        // Attempt to log the current user out.
        let success = await TMDSession.deleteSession(sessionID: sessionID)
        
        // Was the logout successful?
        if success {
            // Yes, clear session ID.
            sessionID = ""
            
            // Reset the user account to guest
            account = TMDAccount()
        }
        
        // Return status
        return success
    }
    
    /// Gets a collection of media from The Movie Database.
    /// - Parameters:
    ///   - accountID: The Movie Database Account ID to return a collection for.
    ///   - collection: The collection to return data from.
    ///   - media: The type of media to return in the collection.
    ///   - pageNumber: The page number to return data for. The defaut is 1.
    ///   - sort: The sort direction. The default is Ascending.
    ///   - language: The language to return data in. The default is "en-US".
    /// - Returns: Returns a `Data` collection if successful.
    public static func getCollection(accountID:Int, collection:TMDCollectionType, media:TMDMediaType, pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async throws -> Data {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/account/\(accountID)/\(collection.rawValue)/\(media.rawValue)")
            .addParameter(name: "session_id", value: sessionID)
            .addParameter(name: "page", value: pageNumber)
            .addParameter(name: "sort_by", value: sort.rawValue)
            .addParameter(name: "language", value: language)
     
        // Ensure we have a good url
        guard let url = endpoint.url else {
            // No, throw an error.
            throw TMDError.invalidURL(url: endpoint.urlString)
        }
        
        // Get data from The Movie Database.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "getCollection", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return the results
        return data
    }
    
    
    /// Gets a guest session collection from The Movie Database.
    /// - Parameters:
    ///   - collection: The collection to return data from.
    ///   - media: The type of media to return in the collection.
    ///   - pageNumber: The page number to return data for. The defaut is 1.
    ///   - sort: The sort direction. The default is Ascending.
    ///   - language: The language to return data in. The default is "en-US".
    /// - Returns: Returns a `Data` collection if successful.
    public static func getGuestCollection(collection:TMDCollectionType, media:TMDMediaType, pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async throws -> Data {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/guest_session/")
            .addPathParameter(parameter: sessionID)
            .addPathParameter(parameter: collection.rawValue)
            .addPathParameter(parameter: media.rawValue)
            .addParameter(name: "page", value: pageNumber)
            .addParameter(name: "sort_by", value: sort.rawValue)
            .addParameter(name: "language", value: language)
     
        // Ensure we have a good url
        guard let url = endpoint.url else {
            // No, throw an error.
            throw TMDError.invalidURL(url: endpoint.urlString)
        }
        
        // Get data from The Movie Database.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "getCollection", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return the results
        return data
    }
    
    /// Gets a collection of data from the user's account on The Movie Database.
    /// - Parameters:
    ///   - accountID: The account ID.
    ///   - collection: The collection to return data from.
    ///   - pageNumber: THe page number to return.
    /// - Returns: Returns a `Data` collection if successful.
    public static func getCollection(accountID:Int, collection:TMDCollectionType, pageNumber:Int = 1) async throws -> Data {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/account/\(accountID)/\(collection.rawValue)")
            .addParameter(name: "session_id", value: sessionID)
            .addParameter(name: "page", value: pageNumber)
     
        // Ensure we have a good url
        guard let url = endpoint.url else {
            // No, throw an error.
            throw TMDError.invalidURL(url: endpoint.urlString)
        }
        
        // Get data from The Movie Database.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "getCollection", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return the results
        return data
    }
    
    /// Gets a collection of the given type from The Movie Database.
    /// - Parameters:
    ///   - collection: The collection type.
    ///   - collectionID: The collection ID.
    ///   - media: The type of media to return. The default is any.
    ///   - language: The language code. The defaut is "en-US".
    /// - Returns: Returns a `Data` collection if successful.
    public static func getCollection(collection:TMDCollectionType, collectionID:Int, media:TMDMediaType = .any, language:String = "en-US") async throws -> Data {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/\(collection.rawValue)/\(collectionID)")
            .addPathParameter(parameter: media.rawValue)
            .addParameter(name: "session_id", value: sessionID)
            .addParameter(name: "language", value: language)
     
        // Ensure we have a good url
        guard let url = endpoint.url else {
            // No, throw an error.
            throw TMDError.invalidURL(url: endpoint.urlString)
        }
        
        // Get data from The Movie Database.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "getCollection", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return the results
        return data
    }
    
    /// Gets a collection of the given type from The Movie Database.
    /// - Parameters:
    ///   - collection: The collection type.
    ///   - collectionID: The collection ID.
    ///   - media: The type of media to return. The default is any.
    ///   - includeAdult: If `true` include adult content, else exclude it.
    ///   - page: The page number to return.
    ///   - language: The language code. The defaut is "en-US".
    /// - Returns: Returns a `Data` collection if successful.
    public static func getCollection(collection:TMDCollectionType, collectionID:Int, media:TMDMediaType = .any, includeAdult:Bool = false, page: Int = 1, language:String = "en-US") async throws -> Data {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/\(collection.rawValue)/\(collectionID)")
            .addPathParameter(parameter: media.rawValue)
            .addParameter(name: "session_id", value: sessionID)
            .addParameter(name: "include_adult", value: includeAdult)
            .addParameter(name: "language", value: language)
            .addParameter(name: "page", value: page)
     
        // Ensure we have a good url
        guard let url = endpoint.url else {
            // No, throw an error.
            throw TMDError.invalidURL(url: endpoint.urlString)
        }
        
        // Get data from The Movie Database.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "getCollection", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return the results
        return data
    }
    
    /// Gets a list of data from The Movie Database.
    /// - Parameters:
    ///   - dataType: The type of data to return.
    ///   - media: The media type to return.
    ///   - collection: The collection type to return.
    ///   - includeSession: If `true` include a session ID, else don't include.
    /// - Returns: Returns a `Data` collection if successful.
    public static func getList(dataType:TMDDataType, media:TMDMediaType, collection:TMDCollectionType, includeSession:Bool = true) async throws -> Data {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3")
            .addPathParameter(parameter: dataType.rawValue)
            .addPathParameter(parameter: media.rawValue)
            .addPathParameter(parameter: collection.rawValue)
        
        // Includes a session ID?
        if includeSession{
            // Yes, add session to the parameters.
            endpoint.addParameter(name: "session_id", value: sessionID)
        }
     
        // Ensure we have a good url
        guard let url = endpoint.url else {
            // No, throw an error.
            throw TMDError.invalidURL(url: endpoint.urlString)
        }
        
        // Get data from The Movie Database.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "getCollection", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return the results
        return data
    }
    
    /// Gets the details and contents of a user list.
    /// - Parameters:
    ///   - listID: The ID of the list to get the contents of.
    ///   - page: The page to load. The default is 1.
    ///   - language: The language to get the items in. The default is "en-US".
    /// - Returns: Returns a `Data` collection if successful.
    public static func getListContents(listID:Int, page:Int = 1, language:String = "en-US") async throws -> Data {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/list/\(listID)")
            .addParameter(name: "page", value: page)
            .addParameter(name: "language", value: language)
     
        // Ensure we have a good url
        guard let url = endpoint.url else {
            // No, throw an error.
            throw TMDError.invalidURL(url: endpoint.urlString)
        }
        
        // Get data from The Movie Database.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "getListContents", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return the results
        return data
    }
    
    /// Gets the given item details from The Movie Database.
    /// - Parameters:
    ///   - dataType: The data type.
    ///   - dataID: The unique ID of the data.
    ///   - media: The type of media to return. The default is any.
    ///   - includeSession: If `true` use the currecgt session ID, else ndo not use it.
    /// - Returns: Returns a `Data` collection if successful.
    public static func getDetails(dataType:TMDDataType, dataID:Int, media:TMDMediaType = .any, includeSession: Bool = true) async throws -> Data {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/\(dataType.rawValue)/\(dataID)")
            .addPathParameter(parameter: media.rawValue)
        
        // Include the session ID?
        if includeSession {
            // Yes, use as a parameter.
            endpoint.addParameter(name: "session_id", value: sessionID)
        }
     
        // Ensure we have a good url
        guard let url = endpoint.url else {
            // No, throw an error.
            throw TMDError.invalidURL(url: endpoint.urlString)
        }
        
        // Get data from The Movie Database.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "getCollection", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return the results
        return data
    }
    
    /// Gets the details for the given data type.
    /// - Parameters:
    ///   - dataType: The data type.
    ///   - media: The type of media to return. The default is any.
    /// - Returns: Returns a `Data` collection if successful.
    public static func getDetails(dataType:TMDDataType, media:TMDMediaType = .any) async throws -> Data {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/\(dataType.rawValue)")
            .addPathParameter(parameter: media.rawValue)
            .addParameter(name: "session_id", value: sessionID)
     
        // Ensure we have a good url
        guard let url = endpoint.url else {
            // No, throw an error.
            throw TMDError.invalidURL(url: endpoint.urlString)
        }
        
        // Get data from The Movie Database.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "getCollection", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return the results
        return data
    }
    
    /// Adds or removes the given media from the given collection in The Movie Database.
    /// - Parameters:
    ///   - accountID: The Movie Database Account ID to return a collection for.
    ///   - collection: The collection to return data from.
    ///   - media: The type of media to return in the collection.
    ///   - mediaID: The ID of the media to adjust.
    ///   - inCollection: If `true` add the media to the collection. If `false` remove the media from the collection.
    /// - Returns: Returns `true` if the collection was adjusted, else returns `false` on failure.
    public static func adjustCollection(accountID:Int, collection:TMDCollectionType, media:TMDMediaType, mediaID:Int, inCollection:Bool) async throws -> Bool {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/account/\(accountID)/\(collection.rawValue)")
            .addParameter(name: "session_id", value: sessionID)
        
        // Ensure we have a good url
        guard let url = endpoint.url else {return false}
        
        // Assemble post body.
        let body = HTTPBodyBuilder("""
            {
              "media_id": <id>,
              "media_type": "<type>",
              "<collection>": <inCollection>
            }
            """)
            .addParameter(name: "id", Value: mediaID)
            .addParameter(name: "type", Value: media.rawValue)
            .addParameter(name: "collection", Value: collection.rawValue)
            .addParameter(name: "inCollection", Value: inCollection)
        
        // Create and configure the request.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "content-type": "application/json"
        ]
        request.httpBody = body.data

        // Post the data to THe Movie Database.
        let (_, response) = try await URLSession.shared.data(for: request)
    
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "adjustCollection", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return success
        return true
    }
    
    /// Adds the give media to a list.
    /// - Parameters:
    ///   - listID: The ID of the list to add to.
    ///   - media: The type of media to add.
    ///   - mediaID: The ID of the media to add.
    /// - Returns: Returns `true` if the list was adjusted, else returns `false` on failure.
    public static func addToList(listID:Int, media:TMDMediaType, mediaID:Int) async throws -> Bool {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/list/\(listID)/add_item")
            .addParameter(name: "session_id", value: sessionID)
        
        // Ensure we have a good url
        guard let url = endpoint.url else {return false}
        
        // Assemble post body.
        let body = HTTPBodyBuilder("""
            {
              "media_id": <id>,
              "media_type": "<type>",
              "list_id": <listID>
            }
            """)
            .addParameter(name: "id", Value: mediaID)
            .addParameter(name: "type", Value: media.rawValue)
            .addParameter(name: "listID", Value: listID)
        
        // Create and configure the request.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "content-type": "application/json"
        ]
        request.httpBody = body.data

        // Post the data to THe Movie Database.
        let (_, response) = try await URLSession.shared.data(for: request)
    
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "addToList", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return success
        return true
    }
    
    /// Removes a media item from a list.
    /// - Parameters:
    ///   - listID: The list ID to remove the media from.
    ///   - media: The type of media.
    ///   - mediaID: The media ID.
    /// - Returns: Returns `true` if the list was adjusted, else returns `false` on failure.
    public static func removeFromList(listID:Int, media:TMDMediaType, mediaID:Int) async throws -> Bool {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/list/\(listID)/remove_item")
            .addParameter(name: "session_id", value: sessionID)
        
        // Ensure we have a good url
        guard let url = endpoint.url else {return false}
        
        // Assemble post body.
        let body = HTTPBodyBuilder("""
            {
              "items": [
                {
                  "media_type": "<type>",
                  "media_id": <id>
                }
              ]
            }
            """)
            .addParameter(name: "id", Value: mediaID)
            .addParameter(name: "type", Value: media.rawValue)
        
        // Create and configure the request.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "content-type": "application/json"
        ]
        request.httpBody = body.data

        // Post the data to THe Movie Database.
        let (_, response) = try await URLSession.shared.data(for: request)
    
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "addToList", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return success
        return true
    }
    
    /// Checks to see if a media item is in a list.
    /// - Parameters:
    ///   - listID: The ID of the list to check.
    ///   - media: The type of media to check for.
    ///   - mediaID: The ID of the media item to check for.
    ///   - language: The language to check in.
    /// - Returns: Returns `true` if the item is in the list or `false` if the item is not or if an invalid type is checked.
    public static func isItemInList(listID:Int, media:TMDMediaType, mediaID:Int, language: String = "en-US") async throws -> Bool {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/list/\(listID)/item_status")
            .addParameter(name: "language", value: language)
        
        // Take action based on the media type.
        switch(media) {
        case .movie:
            // Check for a movie.
            endpoint.addParameter(name: "movie_id", value: mediaID)
            break
            
        case .tvShow:
            // Check for a tv show.
            endpoint.addParameter(name: "tv_id", value: mediaID)
            break
            
        default:
            // Return false on invalid types.
            return false
        }
     
        // Ensure we have a good url
        guard let url = endpoint.url else {
            // No, throw an error.
            throw TMDError.invalidURL(url: endpoint.urlString)
        }
        
        // Get data from The Movie Database.
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "isItemInList", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Attempt to read the returned data.
        let results = try JSONDecoder().decode(TMDPresent.self, from: data)
        
        // Return the results
        return results.itemPresent
    }
    
    /// Clears all items from the given list.
    /// - Parameters:
    ///   - listID: The ID of the list to clear items from.
    ///   - confirm: If `true` confirm the deletion.
    /// - Returns: Returns `true` if successful or `false` on error.
    public static func clearList(listID:Int, confirm:Bool = false) async throws -> Bool {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/list/\(listID)/clear")
            .addParameter(name: "session_id", value: sessionID)
            .addParameter(name: "confirm", value: confirm)
        
        // Ensure we have a good url
        guard let url = endpoint.url else {return false}
        
        // Assemble post body.
        let body = HTTPBodyBuilder("")
        
        // Create and configure the request.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "content-type": "application/json"
        ]
        //request.httpBody = body.data

        // Post the data to THe Movie Database.
        let (_, response) = try await URLSession.shared.data(for: request)
    
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "clearList", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return success
        return true
    }
    
    /// Creates a new user list.
    /// - Parameters:
    ///   - name: The name of the list to create.
    ///   - description: The new list's description.
    /// - Returns: Returns a `Data` collection if successful.
    public static func createList(name:String, description:String) async throws -> Data? {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/list")
            .addParameter(name: "session_id", value: sessionID)
        
        // Ensure we have a good url
        guard let url = endpoint.url else {return nil}
        
        // Assemble post body.
        let body = HTTPBodyBuilder("""
            {
              "name": <name>,
              "description": "<description>",
            }
            """)
            .addParameter(name: "name", Value: name)
            .addParameter(name: "description", Value: description)
        
        // Create and configure the request.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "content-type": "application/json"
        ]
        request.httpBody = body.data

        // Post the data to THe Movie Database.
        let (data, response) = try await URLSession.shared.data(for: request)
    
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "createList", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return success
        return data
    }
    
    /// Deletes the given user list.
    /// - Parameter listID: The ID of the list to delete.
    /// - Returns: Returns `true` if successful or `false` on error.
    public static func deleteList(listID:Int) async throws -> Bool {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/list/\(listID)")
            .addParameter(name: "session_id", value: sessionID)
        
        // Ensure we have a good url
        guard let url = endpoint.url else {return false}
        
        // Assemble post body.
        let body = HTTPBodyBuilder("")
        
        // Create and configure the request.
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "content-type": "application/json"
        ]
        //request.httpBody = body.data

        // Post the data to THe Movie Database.
        let (_, response) = try await URLSession.shared.data(for: request)
    
        // Can we get the status code?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            // No, throw an error.
            throw TMDError.invalidStatusCode(statusCode: -1)
        }
        
        // Was the action successful?
        guard (200...299).contains(statusCode) else {
            throw TMDError.invalidStatusCode(statusCode: statusCode)
        }
        
        // Testing
        // Debug.info(subsystem: "TMDEndpoint", category: "deleteList", String(data: data, encoding: .utf8) ?? "No Data Returned")
        
        // Return success
        return true
    }
}
