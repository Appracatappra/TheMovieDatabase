//
//  TMDAccountEpisodes.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

import Foundation
import LogManager

/// Holds a list of TV Show Episodes related to a specific user.
open class TMDAccountEpisodes: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets the collection of TV Show Episodes that the user has rated from the movie database.
    /// - Parameters:
    ///   - pageNumber: The page number to return. The default is 1.
    ///   - sort: The sort order. The default is ascending.
    ///   - language: The langauge to return the results in. The default is "en-US".
    /// - Returns: Returns the rated list or `nil` if unable to load.
    public static func getRated(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDAccountEpisodes? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(accountID: TMDEndpoint.accountID, collection: .rated, media: .tvEpisode, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDAccountEpisodes.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDAccountEpisodes", category: "getRated", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// The current page number.
    public var page: Int
    
    /// The matching collection of TV Show Episodes.
    public var results: [TMDTVEpisode]
    
    /// The total number of pages.
    public var totalPages: Int
    
    /// The total number of matching results.
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
    ///   - results: The matching collection of TV Show Episodes.
    ///   - totalPages: The total number of pages.
    ///   - totalResults: The total number of matching results.
    public init(page: Int, results: [TMDTVEpisode], totalPages: Int, totalResults: Int) {
        
        // Initialize.
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
