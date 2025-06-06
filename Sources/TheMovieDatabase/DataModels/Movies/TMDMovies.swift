//
//  TMDMovies.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/22/25.
//

import Foundation
import LogManager
import UrlUtilities

/// Holds a collection of the user's movies from The Movie Database.
open class TMDMovies: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Search for movies based on a set of movie query criteria.
    /// - Parameters:
    ///   - query: The criteria used to find movies.
    ///   - pageNumber: The page number to return. The default is 1.
    /// - Returns: Returns a collection of matching movies or `nil` if unable to load.
    public static func discover(query:TMDMovieQuery, pageNumber:Int = 1) async -> TMDMovies? {
        
        // Configure url for REST api call
        // NOTE: I had to break these into sections to get it to compile correctly.
        let endpoint = URLBuilder("https://api.themoviedb.org/3/discover/movie")
            .addParameter(name: "page", value: pageNumber)
            .addParameter(name: "certification", value: query.certifications.certification)
            .addParameter(name: "certification.gte", value: query.certifications.certificationGreaterThan)
            .addParameter(name: "certification.lte", value: query.certifications.certificationLessThan)
            .addParameter(name: "certification_country", value: query.certifications.certificationCountry)
            .addParameter(name: "include_adult", value: query.includeAdult)
            
        endpoint.addParameter(name: "include_video", value: query.includeVideo)
            .addParameter(name: "language", value: query.language)
            .addParameter(name: "primary_release_year", value: query.dates.primaryReleaseYear)
            .addParameter(name: "primary_release_date.gte", value: query.dates.primaryReleaseDateGreaterThan)
            .addParameter(name: "primary_release_date.lte", value: query.dates.primaryReleaseDateLessThan)
            
        endpoint.addParameter(name: "region", value: query.region)
            .addParameter(name: "release_date.gte", value: query.dates.releaseDateGreaterThan)
            .addParameter(name: "release_date.lte", value: query.dates.releaseDateLessThan)
            .addParameter(name: "sort_by", value: query.sortBy)
            .addParameter(name: "vote_average.gte", value: query.votes.voteAverageGreaterThan)
            .addParameter(name: "vote_average.lte", value: query.votes.voteAverageLessThan)
            .addParameter(name: "vote_count.gte", value: query.votes.voteCountGreaterThan)
            .addParameter(name: "vote_count.lte", value: query.votes.voteCountLessThan)
            .addParameter(name: "watch_region", value: query.watchRegion)
            
        endpoint.addParameter(name: "with_cast", value: query.with.cast)
            .addParameter(name: "with_companies", value: query.with.companies)
            .addParameter(name: "with_crew", value: query.with.crew)
            .addParameter(name: "with_genres", value: query.with.genres)
            .addParameter(name: "with_keywords", value: query.with.keywords)
            .addParameter(name: "with_origin_country", value: query.with.originCountry)
            .addParameter(name: "with_original_language", value: query.with.originalLanguage)
            .addParameter(name: "with_people", value: query.with.people)
            .addParameter(name: "with_release_type", value: query.with.releaseType)
            
        endpoint.addParameter(name: "with_runtime.gte", value: query.with.runtimeGreaterThan)
            .addParameter(name: "with_runtime.lte", value: query.with.runtimeLessThan)
            .addParameter(name: "with_watch_monetization_types", value: query.with.monitization)
            .addParameter(name: "with_watch_providers", value: query.with.watchProviders)
            .addParameter(name: "without_companies", value: query.without.companies)
            .addParameter(name: "without_genres", value: query.without.genres)
            .addParameter(name: "without_keywords", value: query.without.keywords)
            .addParameter(name: "without_watch_providers", value: query.without.watchProviders)
            .addParameter(name: "year", value: query.year)
     
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
            //Debug.info(subsystem: "TMDMovies", category: "discover", String(data: data, encoding: .utf8) ?? "No Data Returned")
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDMovies.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovies", category: "discover", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets a user's collection of favorite movies from the movie database.
    /// - Parameters:
    ///   - pageNumber: The page number to return. The default is 1.
    ///   - sort: The sort order. The default is ascending.
    ///   - language: The langauge to return the results in. The default is "en-US".
    /// - Returns: Returns the favorites list or `nil` if unable to load.
    public static func getFavorites(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDMovies? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(accountID: TMDEndpoint.accountID, collection: .favorites, media: .movies, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDMovies.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovies", category: "getFavorites", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets a list of movies currently playing in the theater.
    /// - Parameters:
    ///   - page: The page number to return. The default is 1.
    ///   - language: The language to return. The default is "en-US".
    ///   - region: The region to return. The default is "US".
    /// - Returns: Returns the list of movies or `nil` if unable to load.
    public static func getNowPlaying(page:Int = 1, language:String = "en-US", region:String = "US") async -> TMDMovies? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getList(media: .movies, collection: .nowPlaying, page: page, language: language, region: region)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDMovies.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovies", category: "getNowPlaying", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets a list of popular movies.
    /// - Parameters:
    ///   - page: The page number to return. The default is 1.
    ///   - language: The language to return. The default is "en-US".
    ///   - region: The region to return. The default is "US".
    /// - Returns: Returns the list of movies or `nil` if unable to load.
    public static func getPopular(page:Int = 1, language:String = "en-US", region:String = "US") async -> TMDMovies? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getList(media: .movies, collection: .popular, page: page, language: language, region: region)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDMovies.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovies", category: "getPopular", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets a list of top rated movies.
    /// - Parameters:
    ///   - page: The page number to return. The default is 1.
    ///   - language: The language to return. The default is "en-US".
    ///   - region: The region to return. The default is "US".
    /// - Returns: Returns the list of movies or `nil` if unable to load.
    public static func getTopRated(page:Int = 1, language:String = "en-US", region:String = "US") async -> TMDMovies? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getList(media: .movies, collection: .topRated, page: page, language: language, region: region)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDMovies.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovies", category: "getTopRated", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets a list of upcoming movies.
    /// - Parameters:
    ///   - page: The page number to return. The default is 1.
    ///   - language: The language to return. The default is "en-US".
    ///   - region: The region to return. The default is "US".
    /// - Returns: Returns the list of movies or `nil` if unable to load.
    public static func getUpcoming(page:Int = 1, language:String = "en-US", region:String = "US") async -> TMDMovies? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getList(media: .movies, collection: .upcoming, page: page, language: language, region: region)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDMovies.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovies", category: "getUpcoming", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets a list of movies matching a given keyword ID.
    /// - Parameters:
    ///   - keywordID: The ID of the keyword to return.
    ///   - includeAdult: If `true` include adult content, else exclude it.
    ///   - page: The page number to return.
    ///   - language: The language code. The defaut is "en-US".
    /// - Returns: Returns the matching movie list or `nil` if unable to load.
    @available(*, deprecated, renamed: "discover", message: "This method is deprecated, you should use TMDMovies.discover instead.")
    public static func matchingKeyword(keywordID: Int, includeAdult:Bool = false, pageNumber:Int = 1, language:String = "en-US") async -> TMDMovies? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(collection: .keyword, collectionID: keywordID, media: .movies, includeAdult: includeAdult, page: pageNumber, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDMovies.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovies", category: "getFavorites", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets the collection of movies that the user has rated from the movie database.
    /// - Parameters:
    ///   - pageNumber: The page number to return. The default is 1.
    ///   - sort: The sort order. The default is ascending.
    ///   - language: The langauge to return the results in. The default is "en-US".
    /// - Returns: Returns the rated list or `nil` if unable to load.
    public static func getRated(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDMovies? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(accountID: TMDEndpoint.accountID, collection: .rated, media: .movies, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDMovies.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovies", category: "getRated", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets the collection of movies that a guest user has rated from the movie database.
    /// - Parameters:
    ///   - pageNumber: The page number to return. The default is 1.
    ///   - sort: The sort order. The default is ascending.
    ///   - language: The langauge to return the results in. The default is "en-US".
    /// - Returns: Returns the rated list or `nil` if unable to load.
    public static func getGuestRated(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDMovies? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getGuestCollection(collection: .rated, media: .movies, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDMovies.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovies", category: "getGuestRated", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Gets a user's collection of watchlist movies from the movie database.
    /// - Parameters:
    ///   - pageNumber: The page number to return. The default is 1.
    ///   - sort: The sort order. The default is ascending.
    ///   - language: The langauge to return the results in. The default is "en-US".
    /// - Returns: Returns the favorites list or `nil` if unable to load.
    public static func getWatchlist(pageNumber:Int = 1, sort:TMDSortOrder = .Ascending, language:String = "en-US") async -> TMDMovies? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getCollection(accountID: TMDEndpoint.accountID, collection: .watchlist, media: .movies, pageNumber: pageNumber, sort: sort, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDMovies.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovies", category: "getWatchlist", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    /// Adds or removes a movie from the user's favorites collection.
    /// - Parameters:
    ///   - movieID: The movie's ID.
    ///   - isFavorite: If `true` add to favorites. If `false` remove from favorites.
    /// - Returns: Returns `true` is successful or `false` on failure.
    public static func setFavorite(movieID:Int, isFavorite:Bool = true) async -> Bool {
        
        // Trap all errors
        do {
            // Attempt to adjust the given collection.
            let result = try await TMDEndpoint.adjustCollection(accountID: TMDEndpoint.accountID, collection: .favorites, media: .movies, mediaID: movieID, inCollection: isFavorite)
            
            // Return result
            return result
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovies", category: "setFavorite", "An unexpected error occurred: \(error)")
            
            // Return false on failure
            return false
        }
    }
    
    /// Adds or removes a movie from the user's favorites collection.
    /// - Parameters:
    ///   - sessionID: The active session ID.
    ///   - movieID: The movie's ID.
    ///   - inWatchlist: If `true` add to watchlist. If `false` remove from watchlist.
    /// - Returns: Returns `true` is successful or `false` on failure.
    public static func setWatchlist(movieID:Int, inWatchlist:Bool = true) async -> Bool {
        
        // Trap all errors
        do {
            // Attempt to adjust the given collection.
            let result = try await TMDEndpoint.adjustCollection(accountID: TMDEndpoint.accountID, collection: .watchlist, media: .movies, mediaID: movieID, inCollection: inWatchlist)
            
            // Return result
            return result
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovies", category: "setWatchlist", "An unexpected error occurred: \(error)")
            
            // Return false on failure
            return false
        }
    }
    
    // MARK: - Properties
    /// Holds a range of dates that the movies fall in.
    public var dates: TMDDateRange?
    
    /// The current page number.
    public var page: Int
    
    /// The list of matching Movies.
    public var results: [TMDMovie]
    
    /// The total number of pages available.
    public var totalPages: Int
    
    /// The total number of films in all pages.
    public var totalResults: Int

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case dates
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - page: The current page number.
    ///   - results: The list of matching Movies.
    ///   - totalPages: The total number of pages available.
    ///   - totalResults: The total number of films in all pages.
    ///   - dates: Holds a range of dates that the movies fall in.
    public init(dates: TMDDateRange?, page: Int, results: [TMDMovie], totalPages: Int, totalResults: Int) {
        self.dates = dates
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
