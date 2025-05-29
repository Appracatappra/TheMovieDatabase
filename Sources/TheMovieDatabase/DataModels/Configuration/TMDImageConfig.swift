//
//  TMDImageConfig.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/29/25.
//

/// Holds information about the image configurations used in The Movie Database.
open class TMDImageConfig: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The base URL used to get an image from The Movie Database.
    public var baseURL: String
    
    /// The base URL used to get an image from The Movie Database using SSL.
    public var secureBaseURL: String
    
    /// The valid backdrop sizes.
    public var backdropSizes: [String]
    
    /// The valid logo sizes.
    public var logoSizes: [String]
    
    /// The valid poster sizes.
    public var posterSizes: [String]
    
    /// The valid profile sizes.
    public var profileSizes: [String]
    
    /// The valid still image sizes.
    public var stillSizes: [String]

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }

    // MARK: - Initializers
    /// Creates a new empty instance.
    public init() {
        
        // Initialize.
        self.baseURL = ""
        self.secureBaseURL = ""
        self.backdropSizes = []
        self.logoSizes = []
        self.posterSizes = []
        self.profileSizes = []
        self.stillSizes = []
    }
    
    /// Creates a new instance.
    /// - Parameters:
    ///   - baseURL: The base URL used to get an image from The Movie Database.
    ///   - secureBaseURL: The base URL used to get an image from The Movie Database using SSL.
    ///   - backdropSizes: The valid backdrop sizes.
    ///   - logoSizes: The valid logo sizes.
    ///   - posterSizes: The valid poster sizes.
    ///   - profileSizes: The valid profile sizes.
    ///   - stillSizes: The valid still image sizes.
    public init(baseURL: String, secureBaseURL: String, backdropSizes: [String], logoSizes: [String], posterSizes: [String], profileSizes: [String], stillSizes: [String]) {
        self.baseURL = baseURL
        self.secureBaseURL = secureBaseURL
        self.backdropSizes = backdropSizes
        self.logoSizes = logoSizes
        self.posterSizes = posterSizes
        self.profileSizes = profileSizes
        self.stillSizes = stillSizes
    }
}
