//
//  TMDChanges.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

import Foundation
import LogManager

/// Holds a collection of changes from The Movie Database.
open class TMDChanges: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets a list of media that has changed in the last 24 hours.
    /// - Parameters:
    ///   - media: The type of media to get changes for. Accepted types are: movie, tv, person.
    /// - Returns: Requests the list of changes or `nil` if unable to return.
    public static func getChanges(media:TMDMediaType) async -> TMDChanges? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getList(dataType: .changes, media: media, collection: .changes)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDChanges.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDChanges", category: "getChanges", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// The current page number.
    public var page: Int
    
    /// The collection of changed media.
    public var results: [TMDMediaIndex]
    
    /// The total number of pages.
    public var totalPages: Int
    
    /// The total number of items on all pages.
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
    ///   - results: The collection of changed media.
    ///   - totalPages: The total number of pages.
    ///   - totalResults: The total number of items on all pages.
    public init(page: Int, results: [TMDMediaIndex], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
