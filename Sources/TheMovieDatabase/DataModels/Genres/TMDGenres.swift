//
//  TMDGenres.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/2/25.
//

import Foundation
import LogManager

/// Holds a list of genres from The Movie Database.
open class TMDGenres: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets the requestes list of genres.
    /// - Parameters:
    ///   - media: The type of media to return genre for. Either `.movie` or `.tvShow`.
    ///   - language: The language to return the genres in. The default is "en-US".
    /// - Returns: Returns the list of genres or an empty list on error.
    public static func getGenres(media: TMDMediaType, language:String = "en-US") async -> TMDGenres {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getList(dataType: .genre, media: media, collection: .list, includeSession: false)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDGenres.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDGenres", category: "getGenres", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return TMDGenres(genres: [])
        }
    }
    
    // MARK: - Properties
    /// A collection of genres.
    public var genres: [TMDGenre] = []

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameter genres: A collection of genres.
    public init(genres: [TMDGenre]) {
        self.genres = genres
    }
}
