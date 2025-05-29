//
//  TMDImageCollection.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

import Foundation

/// Holds an image collection read from The Movie Database.
open class TMDImageCollection: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets the image collection.
    /// - Parameters:
    ///   - collectionID: The collection ID.
    ///   - language: The language code. The default is "en-US".
    /// - Returns: Returns the collection of image or `nil` if unable to load.
    public static func getImages(collectionID:Int, language:String = "en-US") async -> TMDImageCollection? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(collection: .collection, collectionID: collectionID, media: .images, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDImageCollection.self, from: data)
            
            // Return results
            return results
        } catch {
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// A collection of backdrop images.
    public var backdrops: [TMDImage]
    
    /// The unique ID for the collection.
    public var id: Int
    
    /// A collection of poster images.
    public var posters: [TMDImage]

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - backdrops: A collection of backdrop images.
    ///   - id: The unique ID for the collection.
    ///   - posters: A collection of poster images.
    public init(backdrops: [TMDImage], id: Int, posters: [TMDImage]) {
        self.backdrops = backdrops
        self.id = id
        self.posters = posters
    }
}
