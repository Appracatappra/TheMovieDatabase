//
//  TMDTVShow.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/22/25.
//

/// Holds index information about a Movie from The Movie Database.
open class TMDMovie: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// If `true` is film contains adult content or themes. If `false` there is no adult content.
    public var adult: Bool
    
    /// The path to the main backdrop image.
    public var backdropPath: String?
    
    /// A list of genre IDs that the film belongs in.
    public var genreIDS: [Int]
    
    /// The unique ID of the film.
    public var id: Int
    
    /// The original language of the film.
    public var originalLanguage: String
    
    /// The original title of the film.
    public var originalTitle: String
    
    /// A short overview of the film and what it is about.
    public var overview: String
    
    /// The overall popularity of the film on The Movie Database.
    public var popularity: Double
    
    /// The poster image path for the film.
    public var posterPath: String?
    
    /// The original release date for the film.
    public var releaseDate: String
    
    /// The film title.
    public var title: String
    
    /// If `true` there is video, else there is not.
    public var video: Bool
    
    /// The average vote for the film on The Movie Database.
    public var voteAverage: Double
    
    /// The number of votes for the film on The Movie Database.
    public var voteCount: Int
    
    /// The optional user rating for this movie.
    public var rating: Int?

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case rating
    }

    // MARK: - Initializers
    /// Crates a new instance.
    /// - Parameters:
    ///   - adult: If `true` is film contains adult content or themes. If `false` there is no adult content.
    ///   - backdropPath: The path to the main backdrop image.
    ///   - genreIDS: A list of genre IDs that the film belongs in.
    ///   - id: The unique ID of the film.
    ///   - originalLanguage: The original language of the film.
    ///   - originalTitle: The original title of the film.
    ///   - overview: A short overview of the film and what it is about.
    ///   - popularity: The overall popularity of the film on The Movie Database.
    ///   - posterPath: The poster image path for the film.
    ///   - releaseDate: The original release date for the film.
    ///   - title: The film title.
    ///   - video: If `true` there is video, else there is not.
    ///   - voteAverage: The average vote for the film on The Movie Database.
    ///   - voteCount: The number of votes for the film on The Movie Database.
    ///   - rating: The optional user rating for this movie.
    public init(adult: Bool, backdropPath: String?, genreIDS: [Int], id: Int, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String?, releaseDate: String, title: String, video: Bool, voteAverage: Double, voteCount: Int, rating: Int?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
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
        self.rating = rating
    }
}
