//
//  TMDTimezone.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/29/25.
//

import Foundation

/// Holds information about a timezone from The Movie Database.
open class TMDTimezone: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets an array of timezones.
    /// - Returns: Returns the array of timezones or an empty array if unable to load.
    public static func getTimezones() async -> TMDTimezones {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getDetails(dataType: .configuration, media: .timezones)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDTimezones.self, from: data)
            
            // Return results
            return results
        } catch {
            // Return an empty configuration on error.
            return TMDTimezones()
        }
    }
    
    // MARK: - Properties
    /// The language code.
    public var iso3166_1: String
    
    /// A list of timezones for the given language.
    public var zones: [String]

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case zones
    }

    // MARK: - Initializers
    /// Creates a new empty instance.
    public init() {
        
        // Initialize.
        self.iso3166_1 = ""
        self.zones = []
    }
    
    /// Creates a new instance.
    /// - Parameters:
    ///   - iso3166_1: The language code.
    ///   - zones: A list of timezones for the given language.
    public init(iso3166_1: String, zones: [String]) {
        self.iso3166_1 = iso3166_1
        self.zones = zones
    }
}

/// Holds an array of timezones from The Movie Databasse.
public typealias TMDTimezones = [TMDTimezone]
