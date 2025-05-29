//
//  TMDSession.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/21/25.
//

import Foundation

open class TMDSession: Codable, @unchecked Sendable {
    
    // MARK: - Static Funtions
    /// Gets a new Guest Session from The Movie Database endpoint.
    /// - Returns: Returns the request session or `nil` if unable to load.
    public static func getNewSession(requestToken:String) async -> TMDSession? {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/authentication/session/new")
            .addParameter(name: "request_token", value: requestToken)
     
        // Ensure we have a good url
        guard let url = endpoint.url else {return nil}
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDSession.self, from: data)
            
            // Return results
            return results
        } catch {
            // Return empty token
            return nil
        }
    }
    
    /// Deletes the given session from The Movie Database.
    /// - Parameter sessionID: The ID of the session to delete.
    /// - Returns: Returns `true` if deleted, else returns `false`.
    public static func deleteSession(sessionID:String) async -> Bool {
        
        // Trap all errors
        do {
            // Configure url for REST api call
            let endpoint = URLBuilder("https://api.themoviedb.org/3/authentication/session")
                .addParameter(name: "session_id", value: sessionID)
            
            // Ensure we have a good url
            guard let url = endpoint.url else {return false}
            
            // Assemble post body.
            let body = HTTPBodyBuilder("""
                {
                  "session_id": <id>
                }
                """)
                .addParameter(name: "id", Value: sessionID)
            
            // Create and configure the request.
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
              "accept": "application/json",
              "content-type": "application/json"
            ]
            request.httpBody = body.data

            // Post the data to The Movie Database.
            let (_, response) = try await URLSession.shared.data(for: request)
        
            // Can we get the status code?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                // No, return false on error.
                return false
            }
            
            // Was the action successful?
            guard (200...299).contains(statusCode) else {
                // Return false on error.
                return false
            }
            
            // Testing
            // Debug.info(subsystem: "TMDSession", category: "deleteSession", String(data: data, encoding: .utf8) ?? "No Data Returned")
            
            // Return success
            return true
        } catch {
            // Default to false
            return false
        }
    }
    
    // MARK: - Properties
    /// If `true` the request succeeded. If `false` the request failed.
    public var success: Bool = false
    
    /// The guest Session ID.
    public var sessionID:String = ""

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - success: If `true` the request succeeded. If `false` the request failed.
    ///   - guestSessionID: The guest Session ID.
    public init(success: Bool, sessionID: String) {
        self.success = success
        self.sessionID = sessionID
    }
}
