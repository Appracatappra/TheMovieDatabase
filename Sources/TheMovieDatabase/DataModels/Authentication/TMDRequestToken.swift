//
//  TMDRequestToken.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/21/25.
//

import Foundation
import LogManager
import UrlUtilities

/// Create an intermediate request token that can be used to validate a TMDB user login.
open class TMDRequestToken: Codable, @unchecked Sendable {
    
    // MARK: - Static Funtions
    /// Gets a new Request Token from The Movie Database endpoint.
    /// - Returns: Returns the request token or `nil` if unable to load.
    public static func getNewToken() async -> TMDRequestToken? {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/authentication/token/new")
     
        // Ensure we have a good url
        guard let url = endpoint.url else {return nil}
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDRequestToken.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDRequestToken", category: "getNewToken", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets a new Request Token validated against a given TMDB Username and Password.
    /// - Parameters:
    ///   - username: The TMDB Username to validate the request token.
    ///   - password: The TMDB Password to validate the request token.
    /// - Returns: Returns the request token or `nil` if unable to load or validate.
    public static func getLoginToken(username:String, password:String) async -> TMDRequestToken? {
        
        // Get new Request Token
        let request = await getNewToken()
        
        guard let requestToken = request?.requestToken else {return nil}
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/authentication/token/validate_with_login")
            .addParameter(name: "request_token", value: requestToken)
            .addParameter(name: "username", value: username)
            .addParameter(name: "password", value: password)
     
        // Ensure we have a good url
        guard let url = endpoint.url else {return nil}
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDRequestToken.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDRequestToken", category: "getLoginToken", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Propetries
    /// If `true` the request succeeded. If `false` the request failed.
    public var success: Bool = false
    
    /// The date/time in UTC when the token will expire.
    public var expiresAt: String = ""
    
    /// The returned request token.
    public var requestToken: String = ""

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
    
    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - success: If `true` the request succeeded. If `false` the request failed.
    ///   - expiresAt: The date/time in UTC when the token will expire.
    ///   - requestToken: The returned request token.
    public init(success: Bool, expiresAt: String, requestToken: String) {
        
        // Initialize
        self.success = success
        self.expiresAt = expiresAt
        self.requestToken = requestToken
    }
}
