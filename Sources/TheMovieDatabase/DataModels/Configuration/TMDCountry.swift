//
//  TMDCountry.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/29/25.
//

import Foundation

/// Holds information about the count codes used in The Movie Database.
open class TMDCountry: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets an array of country codes.
    /// - Returns: Returns the country code array or an empty array if unable to load.
    public static func getCountries() async -> TMDCountries {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getDetails(dataType: .configuration, media: .countries)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDCountries.self, from: data)
            
            // Return results
            return results
        } catch {
            // Return an empty configuration on error.
            return TMDCountries()
        }
    }
    
    // MARK: - Properties
    /// The country code.
    public var iso3166_1: String
    
    /// The english name for the country.
    public var englishName: String
    
    /// The native name for the country.
    public var nativeName: String

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case englishName = "english_name"
        case nativeName = "native_name"
    }

    // MARK: - Initializers
    public init () {
        
        // Initialize.
        self.iso3166_1 = ""
        self.englishName = ""
        self.nativeName = ""
    }
    
    /// Creates a new instance.
    /// - Parameters:
    ///   - iso3166_1: The country code.
    ///   - englishName: The english name for the country.
    ///   - nativeName: The native name for the country.
    public init(iso3166_1: String, englishName: String, nativeName: String) {
        self.iso3166_1 = iso3166_1
        self.englishName = englishName
        self.nativeName = nativeName
    }
}

/// Type used to specify an array of country information.
public typealias TMDCountries = [TMDCountry]
