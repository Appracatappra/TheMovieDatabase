//
//  TMDGuestSession.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/21/25.
//

import Foundation
import LogManager

/// Guest sessions are a special kind of session that give you some of the functionality of an account, but not all. For example, some of the things you can do with a guest session are; maintain a rated list, a watchlist and a favourite list.
///
/// Guest sessions will automatically be deleted if they are not used within 60 minutes of it being issued.
open class TMDGuestSession: Codable, @unchecked Sendable {
    
    // MARK: - Static Funtions
    /// Gets a new Guest Session from The Movie Database endpoint.
    /// - Returns: Returns the request session or `nil` if unable to load.
    public static func getNewSession() async -> TMDGuestSession? {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/authentication/guest_session/new")
     
        // Ensure we have a good url
        guard let url = endpoint.url else {return nil}
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDGuestSession.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDGuestSession", category: "getNewSession", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// If `true` the request succeeded. If `false` the request failed.
    public var success: Bool = false
    
    /// The guest Session ID.
    public var guestSessionID:String
    
    /// The date/time in UTC when the session will expire.
    public var expiresAt: String

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case success
        case guestSessionID = "guest_session_id"
        case expiresAt = "expires_at"
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - success: If `true` the request succeeded. If `false` the request failed.
    ///   - guestSessionID: The guest Session ID.
    ///   - expiresAt: The date/time in UTC when the session will expire.
    public init(success: Bool, guestSessionID: String, expiresAt: String) {
        self.success = success
        self.guestSessionID = guestSessionID
        self.expiresAt = expiresAt
    }
}
