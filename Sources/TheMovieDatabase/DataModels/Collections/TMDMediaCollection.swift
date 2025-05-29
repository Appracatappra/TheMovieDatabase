//
//  TMDMediaCollection.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

import Foundation

/// Holds a media collection from The Movie Database.
open class TMDMediaCollection: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets the given collection's details from The Movie Database.
    /// - Parameters:
    ///   - collectionID: The collection ID.
    ///   - language: The langauge code. The default value is "en-US".
    /// - Returns: Returns the collection details or `nil` if unable to load.
    public static func getDetails(collectionID:Int, language:String = "en-US") async -> TMDMediaCollection? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(collection: .collection, collectionID: collectionID, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDMediaCollection.self, from: data)
            
            // Return results
            return results
        } catch {
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// The path to the backdrop image.
    public var backdropPath: String
    
    /// The unique ID of the collection.
    public var id: Int
    
    /// The name of the collection.
    public var name: String
    
    /// The collection overview.
    public var overview: String
    
    /// The media items in the collection.
    public var parts: [TMDMedia]
    
    /// The collection poster path.
    public var posterPath: String

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, name, overview, parts
        case posterPath = "poster_path"
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - backdropPath: The path to the backdrop image.
    ///   - id: The unique ID of the collection.
    ///   - name: The name of the collection.
    ///   - overview: The collection overview.
    ///   - parts: The media items in the collection.
    ///   - posterPath: The collection poster path.
    public init(backdropPath: String, id: Int, name: String, overview: String, parts: [TMDMedia], posterPath: String) {
        self.backdropPath = backdropPath
        self.id = id
        self.name = name
        self.overview = overview
        self.parts = parts
        self.posterPath = posterPath
    }
}
