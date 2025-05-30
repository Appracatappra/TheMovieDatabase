//
//  TMDAccountTVShows.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/22/25.
//

import Foundation
import LogManager

/// Holds a collection of the user's movies from The Movie Database.
open class TMDAccountTVShows: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets a user's collection of favorite TV Shows from the movie database.
    /// - Parameters:
    ///   - pageNumber: The page number to return. The default is 1.
    ///   - sort: The sort order. The default is ascending.
    ///   - language: The langauge to return the results in. The default is "en-US".
    /// - Returns: Returns the favorites list or `nil` if unable to load.
    public static func getFavorites(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDAccountTVShows? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(accountID: TMDEndpoint.accountID, collection: .favorites, media: .tvShow, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDAccountTVShows.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDAccountTVShows", category: "getFavorites", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets the collection of TV Shows that the user has rated from the movie database.
    /// - Parameters:
    ///   - pageNumber: The page number to return. The default is 1.
    ///   - sort: The sort order. The default is ascending.
    ///   - language: The langauge to return the results in. The default is "en-US".
    /// - Returns: Returns the rated list or `nil` if unable to load.
    public static func getRated(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDAccountTVShows? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(accountID: TMDEndpoint.accountID, collection: .rated, media: .tvShow, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDAccountTVShows.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDAccountTVShows", category: "getRated", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets a user's collection of watchlist TV Shows from the movie database.
    /// - Parameters:
    ///   - pageNumber: The page number to return. The default is 1.
    ///   - sort: The sort order. The default is ascending.
    ///   - language: The langauge to return the results in. The default is "en-US".
    /// - Returns: Returns the favorites list or `nil` if unable to load.
    public static func getWatchlist(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDAccountTVShows? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(accountID: TMDEndpoint.accountID, collection: .watchlist, media: .tvShow, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDAccountTVShows.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDAccountTVShows", category: "getWatchlist", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Adds or removes a TV Show from the user's favorites collection.
    /// - Parameters:
    ///   - showID: The show's ID.
    ///   - isFavorite: If `true` add to favorites. If `false` remove from favorites.
    /// - Returns: Returns `true` is successful or `false` on failure.
    public static func setFavorite(showID:Int, isFavorite:Bool = true) async -> Bool {
        
        // Trap all errors
        do {
            // Attempt to adjust the given collection.
            let result = try await TMDEndpoint.adjustCollection(accountID: TMDEndpoint.accountID, collection: .favorites, media: .tvShow, mediaID: showID, inCollection: isFavorite)
            
            // Return result
            return result
        } catch {
            // Log error
            Debug.error(subsystem: "TMDAccountTVShows", category: "setFavorite", "An unexpected error occurred: \(error)")
            
            // Return false on failure
            return false
        }
    }
    
    /// Adds or removes a movie from the user's favorites collection.
    /// - Parameters:
    ///   - showID: The show's ID.
    ///   - inWatchlist: If `true` add to watchlist. If `false` remove from watchlist.
    /// - Returns: Returns `true` is successful or `false` on failure.
    public static func setWatchlist(showID:Int, inWatchlist:Bool = true) async -> Bool {
        
        // Trap all errors
        do {
            // Attempt to adjust the given collection.
            let result = try await TMDEndpoint.adjustCollection(accountID: TMDEndpoint.accountID, collection: .watchlist, media: .tvShow, mediaID: showID, inCollection: inWatchlist)
            
            // Return result
            return result
        } catch {
            // Log error
            Debug.error(subsystem: "TMDAccountTVShows", category: "setWatchlist", "An unexpected error occurred: \(error)")
            
            // Return false on failure
            return false
        }
    }
    
    // MARK: - Properties
    /// The current page number.
    public var page: Int
    
    /// The collection of TV Shows returned.
    public var results: [TMDTVShow]
    
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
    ///   - results: The collection of TV Shows returned.
    ///   - totalPages: The total number of pages in the collection.
    ///   - totalResults: The total number of TV Shows in all pages.
    public init(page: Int, results: [TMDTVShow], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
