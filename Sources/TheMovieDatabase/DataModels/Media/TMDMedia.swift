//
//  TMDMedia.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

// Holds information about media from The Movie Database.
open class TMDMedia: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// If `true` is media contains adult content or themes. If `false` there is no adult content.
    public var adult: Bool
    
    /// The path to the backdrop image.
    public var backdropPath: String
    
    /// A character attached to this media.
    public var character: String?
    
    /// A list of genre IDs.
    public var genreIDS: [Int]
    
    /// The unique media ID.
    public var id: Int
    
    /// The media type.
    public var mediaType: String
    
    /// The original language.
    public var originalLanguage: String
    
    /// The original title.
    public var originalTitle: String
    
    /// The media overview.
    public var overview: String
    
    /// The media popularity.
    public var popularity: Double
    
    /// The media poster path.
    public var posterPath: String
    
    /// The media release date.
    public var releaseDate: String
    
    /// The movie title.
    public var title: String
    
    /// If `true` there is video, else there is not.
    public var video: Bool
    
    /// The vote average.
    public var voteAverage: Double
    
    /// The vote count.
    public var voteCount: Int

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case character
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - adult: If `true` is media contains adult content or themes. If `false` there is no adult content.
    ///   - backdropPath: The path to the backdrop image.
    ///   - character: A character attached to this media.
    ///   - genreIDS: A list of genre IDs.
    ///   - id: The unique media ID.
    ///   - mediaType: The media type.
    ///   - originalLanguage: The original language.
    ///   - originalTitle: The original title.
    ///   - overview: The media overview.
    ///   - popularity: The media popularity.
    ///   - posterPath: The media poster path.
    ///   - releaseDate: The media release date.
    ///   - title: The movie title.
    ///   - video: If `true` there is video, else there is not.
    ///   - voteAverage: The vote average.
    ///   - voteCount: The vote count.
    public init(adult: Bool, backdropPath: String, character: String?, genreIDS: [Int], id: Int, mediaType: String, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String, releaseDate: String, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.character = character
        self.genreIDS = genreIDS
        self.id = id
        self.mediaType = mediaType
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
