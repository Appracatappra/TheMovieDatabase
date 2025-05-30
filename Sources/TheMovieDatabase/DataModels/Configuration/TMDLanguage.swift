//
//  TMDLanguage.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/29/25.
//
import Foundation
import LogManager

/// Holds information about a language code used in The Movie Database.
open class TMDLanguage: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets an array of language codes.
    /// - Returns: Returns the array of language codes or an empty array if unable to load.
    public static func getLanguages() async -> TMDLanguages {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getDetails(dataType: .configuration, media: .languages)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDLanguages.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDLanguage", category: "getLanguages", "An unexpected error occurred: \(error)")
            
            // Return an empty configuration on error.
            return TMDLanguages()
        }
    }
    
    // MARK: - Properties
    /// The code used for the language.
    public var iso639_1: String
    
    /// The english name of the language.
    public var englishName: String
    
    /// The native name of the language.
    public var name: String

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case englishName = "english_name"
        case name
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - iso639_1: The code used for the language.
    ///   - englishName: The english name of the language.
    ///   - name: The native name of the language.
    public init(iso639_1: String, englishName: String, name: String) {
        self.iso639_1 = iso639_1
        self.englishName = englishName
        self.name = name
    }
}

/// Holds an array of language codes used in The Movie Database.
public typealias TMDLanguages = [TMDLanguage]
