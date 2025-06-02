//
//  TMDFind.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/2/25.
//

import Foundation
import LogManager

/**
 Find media in The Movie Database by external ID's. The find method makes it easy to search for objects in our database by an external identifier. This method will search all objects (movies, TV shows and people) and return the results in a single response.

 The supported external sources for each object are as follows:
 
 * **IMDB** - Movies, TV Shows, Episodes, People.
 * **Facebook** - Movies, TV Shows,  People.
 * **Instagram** - Movies, TV Shows,  People.
 * **TheTVDB** - TV Shows,  Seasons, Episodes.
 * **TikTok** - Movies, TV Shows,  People.
 * **Twitter** - Movies, TV Shows,  People.
 * **Wikidata** - Movies, TV Shows, Seasons, Episodes, People.
 * **YouTube** - Movies, TV Shows,  People.
 */
open class TMDFind: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Locates matching media in The Movie Database from an external source.
    /// - Parameters:
    ///   - externalID: The external ID.
    ///   - provider: The external source.
    ///   - language: The language to return results in. The default is "en-US".
    /// - Returns: Returns any matching media or `nil` if unable to load.
    public static func locate(externalID: String, provider:TMDExternalID, language: String = "en-US") async -> TMDFind? {
        
        // Configure url for REST api call
        let endpoint = URLBuilder("https://api.themoviedb.org/3/find")
            .addPathParameter(parameter: externalID)
            .addParameter(name: "external_source", value: provider.rawValue)
            .addParameter(name: "language", value: language)
     
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
            //Debug.info(subsystem: "TMDFind", category: "locate", String(data: data, encoding: .utf8) ?? "No Data Returned")
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDFind.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDFind", category: "locate", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// Holds any matching movie results.
    public var movieResults: [TMDMovie] = []
    
    /// Holds any people movie results.
    public var personResults: [TMDPerson] = []
    
    /// Holds any matching TV Show results.
    public var tvResults: [TMDTVShow] = []
    
    /// Holds any matching episode results.
    public var tvEpisodeResults: [TMDTVEpisode] = []
    
    /// Holds any matching season results.
    public var tvSeasonResults: [TMDTVSeason] = []

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
        case personResults = "person_results"
        case tvResults = "tv_results"
        case tvEpisodeResults = "tv_episode_results"
        case tvSeasonResults = "tv_season_results"
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - movieResults: Holds any matching movie results.
    ///   - personResults: Holds any people movie results.
    ///   - tvResults: Holds any matching TV Show results.
    ///   - tvEpisodeResults: Holds any matching episode results.
    ///   - tvSeasonResults: Holds any matching season results.
    public init(movieResults: [TMDMovie], personResults: [TMDPerson], tvResults: [TMDTVShow], tvEpisodeResults: [TMDTVEpisode], tvSeasonResults: [TMDTVSeason]) {
        self.movieResults = movieResults
        self.personResults = personResults
        self.tvResults = tvResults
        self.tvEpisodeResults = tvEpisodeResults
        self.tvSeasonResults = tvSeasonResults
    }
}
