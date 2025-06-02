//
//  TMDTVSeason.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/2/25.
//

import Foundation

/// Holds information about a TV Show Season from The Movie Database.
open class TMDTVSeason: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The unique ID of the season.
    public var id: Int
    
    /// The TV Show Name.
    public var name: String
    
    /// The TV Show overview.
    public var overview: String
    
    /// The path to the poster image.
    public var posterPath: String?
    
    /// The media type.
    public var mediaType: String
    
    /// The average vote.
    public var voteAverage: Int
    
    /// The air date of the season.
    public var airDate: String
    
    /// The season number.
    public var seasonNumber: Int
    
    /// The show's unique ID.
    public var showID: Int
    
    /// The number of episodes in the season.
    public var episodeCount: Int

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case id, name, overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case voteAverage = "vote_average"
        case airDate = "air_date"
        case seasonNumber = "season_number"
        case showID = "show_id"
        case episodeCount = "episode_count"
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - id: The unique ID of the season.
    ///   - name: The TV Show Name.
    ///   - overview: The TV Show overview.
    ///   - posterPath: The path to the poster image.
    ///   - mediaType: The media type.
    ///   - voteAverage: The average vote.
    ///   - airDate: The air date of the season.
    ///   - seasonNumber: The season number.
    ///   - showID: The show's unique ID.
    ///   - episodeCount: The number of episodes in the season.
    public init(id: Int, name: String, overview: String, posterPath: String?, mediaType: String, voteAverage: Int, airDate: String, seasonNumber: Int, showID: Int, episodeCount: Int) {
        self.id = id
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
        self.mediaType = mediaType
        self.voteAverage = voteAverage
        self.airDate = airDate
        self.seasonNumber = seasonNumber
        self.showID = showID
        self.episodeCount = episodeCount
    }
}
