//
//  TMDTVEpisodes.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/2/25.
//

import Foundation
import LogManager

/// Holds a collection of TV episodes returned from The Movie Database.
open class TMDTVEpisodes: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets the collection of TV Shows that a guest user has rated from the movie database.
    /// - Parameters:
    ///   - pageNumber: The page number to return. The default is 1.
    ///   - sort: The sort order. The default is ascending.
    ///   - language: The langauge to return the results in. The default is "en-US".
    /// - Returns: Returns the rated list or `nil` if unable to load.
    public static func getGuestRated(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDTVEpisodes? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getGuestCollection(collection: .rated, media: .tvEpisodes, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDTVEpisodes.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDTVEpisodes", category: "getGuestRated", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// The current page number.
    public var page: Int
    
    /// The collection of TV episodes returned.
    public var results: [TMDTVEpisode]
    
    /// The total number of pages in the collection.
    public var totalPages: Int
    
    /// The total number of TV Shows in all pages.
    public var totalResults: Int

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - page: The current page number.
    ///   - results: The collection of TV episodes returned.
    ///   - totalPages: The total number of pages in the collection.
    ///   - totalResults: The total number of TV Shows in all pages.
    public init(page: Int, results: [TMDTVEpisode], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
