//
//  TMDMovieDetails.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/3/25.
//
import Foundation
import LogManager

/// Holds the full details of a movie from The Movie Database.
open class TMDMovieDetails: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets the details for the given media type and ID.
    /// - Parameters:
    ///   - movieID: The ID of the movie to get details for.
    ///   - language: The language to get the details in. The default is "en-US".
    /// - Returns: Returns the movie details if successful, else returns `nil`.
    public static func getUpcoming(movieID:Int, language:String = "en-US") async -> TMDMovieDetails? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getMediaDetails(media: .movie, mediaID: movieID, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDMovieDetails.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDMovieDetails", category: "getUpcoming", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// If `true` is film contains adult content or themes. If `false` there is no adult content.
    public var adult: Bool
    
    /// The path to the backdrop image.
    public var backdropPath: String?
    
    /// The collection this movie belongs to.
    public var belongsToCollection: TMDMediaCollection?
    
    /// The movie's budget.
    public var budget: Int
    
    /// The genres the movie belongs in.
    public var genres: [TMDGenre]
    
    /// The movie's home page.
    public var homepage: String
    
    /// The movie's unique ID.
    public var id: Int
    
    /// The movie's IMDB ID.
    public var imdbID: String
    
    /// The contries of origin.
    public var originCountry: [String]
    
    /// The original language.
    public var originalLanguage: String
    
    /// The original title.
    public var originalTitle: String
    
    /// An overview of the movie.
    public var overview: String
    
    /// The movie's popularity.
    public var popularity: Double
    
    /// The movie's poster path.
    public var posterPath: String?
    
    /// A list of production companies.
    public var productionCompanies: [TMDProductionCompany]
    
    /// A list of production countries.
    public var productionCountries: [TMDProductionCountry]
    
    /// The movie's release date.
    public var releaseDate: String
    
    /// The movie's revenue.
    public var revenue: Int
    
    /// The movie's runtime.
    public var runtime: Int
    
    /// The list of spoken languages.
    public var spokenLanguages: [TMDSpokenLanguage]
    
    /// The movie's status.
    public var status: String
    
    /// The movie's tagline.
    public var tagline: String
    
    /// The movie's title.
    public var title: String
    
    /// If `true` there is video, else there is not.
    public var video: Bool
    
    /// The average vote for the film on The Movie Database.
    public var voteAverage: Double
    
    /// The number of votes for the film on The Movie Database.
    public var voteCount: Int

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    // MARK: - Initializers
    /// Creates new instance.
    /// - Parameters:
    ///   - adult: If `true` is film contains adult content or themes. If `false` there is no adult content.
    ///   - backdropPath: The path to the backdrop image.
    ///   - belongsToCollection: The collection this movie belongs to.
    ///   - budget: The movie's budget.
    ///   - genres: The genres the movie belongs in.
    ///   - homepage: The movie's home page.
    ///   - id: The movie's unique ID.
    ///   - imdbID: The movie's IMDB ID.
    ///   - originCountry: The contries of origin.
    ///   - originalLanguage: The original language.
    ///   - originalTitle: The original title.
    ///   - overview: An overview of the movie.
    ///   - popularity: The movie's popularity.
    ///   - posterPath: The movie's poster path.
    ///   - productionCompanies: A list of production companies.
    ///   - productionCountries: A list of production countries.
    ///   - releaseDate: The movie's release date.
    ///   - revenue: The movie's revenue.
    ///   - runtime: The movie's runtime.
    ///   - spokenLanguages: The list of spoken languages.
    ///   - status: The movie's status.
    ///   - tagline: The movie's tagline.
    ///   - title: The movie's title.
    ///   - video: If `true` there is video, else there is not.
    ///   - voteAverage: The average vote for the film on The Movie Database.
    ///   - voteCount: The number of votes for the film on The Movie Database.
    public init(adult: Bool, backdropPath: String?, belongsToCollection: TMDMediaCollection?, budget: Int, genres: [TMDGenre], homepage: String, id: Int, imdbID: String, originCountry: [String], originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String?, productionCompanies: [TMDProductionCompany], productionCountries: [TMDProductionCountry], releaseDate: String, revenue: Int, runtime: Int, spokenLanguages: [TMDSpokenLanguage], status: String, tagline: String, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbID = imdbID
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
