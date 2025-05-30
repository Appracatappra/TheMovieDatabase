//
//  TMDTranslationIndex.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/29/25.
//
import Foundation
import LogManager

/// Holds a translation index used in The Movie Database.
open class TMDTranslationIndex: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets an array of primary translation indexes.
    /// - Returns: Returns the translation array or an empty array if unable to load.
    public static func getTranslationIndexes() async -> TMDTranslationIndexes {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getDetails(dataType: .configuration, media: .primaryTranslations)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDTranslationIndexes.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDTranslationIndex", category: "getTranslationIndexes", "An unexpected error occurred: \(error)")
            
            // Return an empty configuration on error.
            return TMDTranslationIndexes()
        }
    }
    
    // MARK: - Porperties
    /// The language code.
    public var iso639_1: String
    
    /// The language name in english.
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

    // MARK: - Initializers.
    /// Creates a new empty instance.
    public init() {
        self.iso639_1 = ""
        self.englishName = ""
        self.name = ""
    }
    
    /// Creates a new instance.
    /// - Parameters:
    ///   - iso639_1: The language code.
    ///   - englishName: The language name in english.
    ///   - name: The native name of the language.
    public init(iso639_1: String, englishName: String, name: String) {
        self.iso639_1 = iso639_1
        self.englishName = englishName
        self.name = name
    }
}

/// Holds an array of translation indexes used in The Movie Databse.
public typealias TMDTranslationIndexes = [TMDTranslationIndex]
