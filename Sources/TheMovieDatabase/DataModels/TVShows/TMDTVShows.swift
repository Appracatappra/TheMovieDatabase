//
//  TMDTVShows.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/22/25.
//

import Foundation
import LogManager

/// Holds a collection of the user's movies from The Movie Database.
open class TMDTVShows: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Finds TV shows by the given query criteria.
    /// - Parameters:
    ///   - query: The criteria to search by.
    ///   - pageNumber: The page number to return.
    /// - Returns: Returns the matching tv shows or `nil` if unable to load.
    public static func discover(query:TMDTvQuery, pageNumber:Int = 1) async -> TMDTVShows? {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/discover/movie")
            .addParameter(name: "page", value: pageNumber)
            .addParameter(name: "air_date.gte", value: query.airDates.airDateGreaterThan)
            .addParameter(name: "air_date.lte", value: query.airDates.airDateLessThan)
            .addParameter(name: "first_air_date_year", value: query.airDates.firstAirDateYear)
            .addParameter(name: "first_air_date.gte", value: query.airDates.firstAirDateGreaterThan)
            .addParameter(name: "first_air_date.lte", value: query.airDates.firstAirDateLessThan)
            .addParameter(name: "include_null_first_air_dates", value: query.airDates.includeNullAirDates)
            .addParameter(name: "include_adult", value: query.includeAdult)
            .addParameter(name: "language", value: query.language)
            .addParameter(name: "screened_theatrically", value: query.screenedTheatrically)
            .addParameter(name: "sort_by", value: query.sortBy.rawValue)
            .addParameter(name: "timezone", value: query.timezone)
            .addParameter(name: "vote_average.gte", value: query.votes.voteAverageGreaterThan)
            .addParameter(name: "vote_average.lte", value: query.votes.voteAverageLessThan)
            .addParameter(name: "vote_count.gte", value: query.votes.voteCountGreaterThan)
            .addParameter(name: "vote_count.lte", value: query.votes.voteCountLessThan)
            .addParameter(name: "watch_region", value: query.watchRegion)
            .addParameter(name: "with_companies", value: query.with.companies)
            .addParameter(name: "with_genres", value: query.with.genres)
            .addParameter(name: "with_keywords", value: query.with.keywords)
            .addParameter(name: "with_networks", value: query.with.networks)
            .addParameter(name: "with_origin_country", value: query.with.originCountry)
            .addParameter(name: "with_original_language", value: query.with.originalLanguage)
            .addParameter(name: "with_runtime.gte", value: query.with.runtimeGreaterThan)
            .addParameter(name: "with_runtime.lte", value: query.with.runtimeLessThan)
            .addParameter(name: "with_status", value: query.with.status.rawValue)
            .addParameter(name: "with_watch_monetization_types", value: query.with.monitization.rawValue)
            .addParameter(name: "with_watch_providers", value: query.with.watchProviders)
            .addParameter(name: "with_type", value: query.with.showType.rawValue)
            .addParameter(name: "without_companies", value: query.without.companies)
            .addParameter(name: "without_genres", value: query.without.genres)
            .addParameter(name: "without_keywords", value: query.without.keywords)
            .addParameter(name: "without_watch_providers", value: query.without.watchProviders)
     
        // Ensure we have a good url
        guard let url = endpoint.url else {return nil}
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Can we get the status code?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                // Return empty token
                return nil
            }
            
            // Was the action successful?
            guard (200...299).contains(statusCode) else {
                // Return empty token
                return nil
            }
            
            // Testing
            //Debug.info(subsystem: "TMDTVShows", category: "discover", String(data: data, encoding: .utf8) ?? "No Data Returned")
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDTVShows.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDTVShows", category: "discover", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets a user's collection of favorite TV Shows from the movie database.
    /// - Parameters:
    ///   - pageNumber: The page number to return. The default is 1.
    ///   - sort: The sort order. The default is ascending.
    ///   - language: The langauge to return the results in. The default is "en-US".
    /// - Returns: Returns the favorites list or `nil` if unable to load.
    public static func getFavorites(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDTVShows? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(accountID: TMDEndpoint.accountID, collection: .favorites, media: .tvShow, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDTVShows.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDTVShows", category: "getFavorites", "An unexpected error occurred: \(error)")
            
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
    public static func getRated(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDTVShows? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(accountID: TMDEndpoint.accountID, collection: .rated, media: .tvShow, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDTVShows.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDTVShows", category: "getRated", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets the collection of TV Shows that a guest user has rated from the movie database.
    /// - Parameters:
    ///   - pageNumber: The page number to return. The default is 1.
    ///   - sort: The sort order. The default is ascending.
    ///   - language: The langauge to return the results in. The default is "en-US".
    /// - Returns: Returns the rated list or `nil` if unable to load.
    public static func getGuestRated(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDTVShows? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getGuestCollection(collection: .rated, media: .tvShow, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDTVShows.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDTVShows", category: "getGuestRated", "An unexpected error occurred: \(error)")
            
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
    public static func getWatchlist(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDTVShows? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(accountID: TMDEndpoint.accountID, collection: .watchlist, media: .tvShow, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDTVShows.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDTVShows", category: "getWatchlist", "An unexpected error occurred: \(error)")
            
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
            Debug.error(subsystem: "TMDTVShows", category: "setFavorite", "An unexpected error occurred: \(error)")
            
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
            Debug.error(subsystem: "TMDTVShows", category: "setWatchlist", "An unexpected error occurred: \(error)")
            
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
