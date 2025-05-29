//
//  TMDTranslationCollection.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

import Foundation

/// Holds a collection of translations from The Movie Database.
open class TMDTranslationCollection: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets a collection of trnaslations.
    /// - Parameters:
    ///   - collectionID: The collection ID.
    /// - Returns: Returns the translation collection or `nil` if unable to load.
    public static func getTranslations(collectionID:Int) async -> TMDTranslationCollection? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(collection: .collection, collectionID: collectionID, media: .translations, language: "")
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDTranslationCollection.self, from: data)
            
            // Return results
            return results
        } catch {
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// The unique ID.
    public var id: Int
    
    /// The list of translations.
    public var translations: [TMDTranslation]

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - id: The unique ID.
    ///   - translations: The list of translations.
    public init(id: Int, translations: [TMDTranslation]) {
        self.id = id
        self.translations = translations
    }
}
