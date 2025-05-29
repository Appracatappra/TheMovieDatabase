//
//  TMDDataClass.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

/// holds the detail information about an entry read from The Movie Database.
open class TMDDataClass: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The entry's homepage.
    public var homepage: String
    
    /// The entry overview.
    public var overview: String
    
    /// The entry title.
    public var title: String

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - homepage: The entry's homepage.
    ///   - overview: The entry overview.
    ///   - title: The entry title.
    public init(homepage: String, overview: String, title: String) {
        self.homepage = homepage
        self.overview = overview
        self.title = title
    }
}
