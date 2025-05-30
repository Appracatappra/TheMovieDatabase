//
//  TMDTVEpisode.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

/// Holds information about a TV Show Episode loaded from The Movie Database.
open class TMDTVEpisode: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// Holds the airdate for the episode.
    public var airDate: String
    
    /// Holds the episode number.
    public var episodeNumber: Int
    
    /// Holds the episode type.
    public var episodeType: String
    
    /// Holds the Unique ID of the episode.
    public var id: Int
    
    /// Holds the episode name.
    public var name: String
    
    /// Holds an oveview of the episode.
    public var overview: String
    
    /// Holds the production code.
    public var productionCode: String
    
    /// Holds the runtime in minutes.
    public var runtime: Int
    
    /// Holds the season number.
    public var seasonNumber: Int
    
    /// Holds the show ID.
    public var showID: Int
    
    /// Holds a path to the episode still.
    public var stillPath: String?
    
    /// Holds the average vote.
    public var voteAverage: Double
    
    /// Holds the vote count.
    public var voteCount: Int
    
    /// Holds the optional user rating.
    public var rating: Int?

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case episodeType = "episode_type"
        case id, name, overview
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case rating
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - airDate: The air date.
    ///   - episodeNumber: The episode number.
    ///   - episodeType: The episode type.
    ///   - id: The episode ID.
    ///   - name: The name of the episode.
    ///   - overview: The episode overview.
    ///   - productionCode: The production code.
    ///   - runtime: The runtime in minutes.
    ///   - seasonNumber: The season number.
    ///   - showID: The show ID.
    ///   - stillPath: The still image path.
    ///   - voteAverage: The average vote.
    ///   - voteCount: The average vote count.
    ///   - rating: The optional user rating.
    public init(airDate: String, episodeNumber: Int, episodeType: String, id: Int, name: String, overview: String, productionCode: String, runtime: Int, seasonNumber: Int, showID: Int, stillPath: String?, voteAverage: Double, voteCount: Int, rating: Int?) {
        
        // Initialize.
        self.airDate = airDate
        self.episodeNumber = episodeNumber
        self.episodeType = episodeType
        self.id = id
        self.name = name
        self.overview = overview
        self.productionCode = productionCode
        self.runtime = runtime
        self.seasonNumber = seasonNumber
        self.showID = showID
        self.stillPath = stillPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.rating = rating
    }
}
