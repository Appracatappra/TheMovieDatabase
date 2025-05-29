//
//  TMDAccountLists.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

import Foundation

/// Holds a collection of list that the user has created on The Movie Database.
open class TMDAccountLists: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets the collection of lists that the user has created on The Movie Database..
    /// - Parameters:
    ///   - accountID: The user's Account ID.
    ///   - pageNumber: The page number to return. The default is 1.
    /// - Returns: Returns the collection of lists  or `nil` if unable to load.
    public static func getRated(accountID:Int, pageNumber:Int = 1) async -> TMDAccountLists? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(accountID: accountID, collection: .list, pageNumber: pageNumber)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDAccountLists.self, from: data)
            
            // Return results
            return results
        } catch {
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// The current page number.
    public var page: Int
    
    /// The collection of matching Lists.
    public var results: [TMDUserList]
    
    /// The total number of pages.
    public var totalPages: Int
    
    /// The total number of results on all pages.
    public var totalResults: Int

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    // MARK: - Constructors
    /// Creates a new instance.
    /// - Parameters:
    ///   - page: The current page number.
    ///   - results: The collection of matching Lists.
    ///   - totalPages: The total number of pages.
    ///   - totalResults: The total number of results on all pages.
    public init(page: Int, results: [TMDUserList], totalPages: Int, totalResults: Int) {
        
        // Initialize.
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
