//
//  TMDSpokenLanguage.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/3/25.
//
import Foundation

/// Holds information about a spoken language from The Movie Database.
open class TMDSpokenLanguage: Codable, @unchecked Sendable {
    
    // MARK: - Properties.
    /// The english name of the language.
    public var englishName: String
    
    /// The language code.
    public var iso639_1: String
    
    /// The language's native name.
    public var name: String

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }

    // MARK: - Initializers
    /// Crreates a new instance.
    /// - Parameters:
    ///   - englishName: The english name of the language.
    ///   - iso639_1: The language code.
    ///   - name: The language's native name.
    public init(englishName: String, iso639_1: String, name: String) {
        self.englishName = englishName
        self.iso639_1 = iso639_1
        self.name = name
    }
}
