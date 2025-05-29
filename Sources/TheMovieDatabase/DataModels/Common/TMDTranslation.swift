//
//  TMDTranslation.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

/// Holds information about a translation from The Movie Database.
open class TMDTranslation: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The translation data.
    public var data: TMDDataClass
    
    /// The english name.
    public var englishName: String
    
    /// The location code.
    public var iso3166_1: String
    
    /// The language code.
    public var iso639_1: String
    
    /// The translation name.
    public var name: String

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case data
        case englishName = "english_name"
        case iso3166_1 = "iso_3166_1"
        case iso639_1 = "iso_639_1"
        case name
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - data: The translation data.
    ///   - englishName: The english name..
    ///   - iso3166_1: The location code.
    ///   - iso639_1: The language code.
    ///   - name: The translation name.
    public init(data: TMDDataClass, englishName: String, iso3166_1: String, iso639_1: String, name: String) {
        self.data = data
        self.englishName = englishName
        self.iso3166_1 = iso3166_1
        self.iso639_1 = iso639_1
        self.name = name
    }
}
