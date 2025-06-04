//
//  TMDAccount.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/21/25.
//

import Foundation
import LogManager
import UrlUtilities

open class TMDAccount: Codable, @unchecked Sendable {
    
    // MARK: - Static Funtions
    /// Gets given account details from The Movie Database endpoint.
    /// - Parameter id: The id of the account to load.
    /// - Returns: Returns the account details or `nil` if unable to load.
    public static func getAccount(id:Int) async -> TMDAccount? {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/account")
            .addPathParameter(id)
     
        // Ensure we have a good url
        guard let url = endpoint.url else {return nil}
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Testing
            //Debug.info(subsystem: "TMDAccount", category: "getAccount", String(data: data, encoding: .utf8) ?? "No Data Returned")
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDAccount.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDAccount", category: "getAccount", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets given account details from The Movie Database endpoint.
    /// - Parameter sessionID: The session ID to return details for.
    /// - Returns: Returns the account details or `nil` if unable to load.
    public static func getAccount(sessionID:String) async -> TMDAccount? {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/account")
            .addParameter(name: "session_id", value: sessionID)
     
        // Ensure we have a good url
        guard let url = endpoint.url else {return nil}
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Testing
            //Debug.info(subsystem: "TMDAccount", category: "getAccount", String(data: data, encoding: .utf8) ?? "No Data Returned")
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDAccount.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDAccount", category: "getAccount", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// The account avatar information.
    public var avatar: TMDAccountAvatar
    
    /// The account ID.
    public var id: Int
    
    /// The user's language code (eg. en).
    public var iso639_1: String
    
    /// The user's country code (eg. US).
    public var iso3166_1: String
    
    /// The user's name.
    public var name: String
    
    /// If `true` the user wants to see adult content, else they do not.
    public var includeAdult: Bool
    
    /// The user's account name.
    public var username: String
    
    // MARK: - Computed Properties
    /// If `true` this is a guest account, else it is a TMD user account.
    public var isGuest: Bool {
        return (self.id == -1)
    }

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }

    // MARK: - Initializers
    /// Creates a new guest account.
    public init() {
        self.avatar = TMDAccountAvatar(gravatarHash: "", avatarPath: "")
        self.id = -1
        self.iso639_1 = "en-US"
        self.iso3166_1 = "US"
        self.name = "Guest User"
        self.includeAdult = false
        self.username = "guest"
    }
    
    /// Creates a new instance.
    /// - Parameters:
    ///   - avatar: The account avatar information.
    ///   - id: The account ID.
    ///   - iso639_1: The user's language code (eg. en).
    ///   - iso3166_1: The user's country code (eg. US).
    ///   - name: The user's name.
    ///   - includeAdult: If `true` the user wants to see adult content, else they do not.
    ///   - username: The user's account name.
    public init(avatar: TMDAccountAvatar, id: Int, iso639_1: String, iso3166_1: String, name: String, includeAdult: Bool, username: String) {
        self.avatar = avatar
        self.id = id
        self.iso639_1 = iso639_1
        self.iso3166_1 = iso3166_1
        self.name = name
        self.includeAdult = includeAdult
        self.username = username
    }
}
