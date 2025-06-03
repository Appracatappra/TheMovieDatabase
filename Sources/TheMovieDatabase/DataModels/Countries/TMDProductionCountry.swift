//
//  TMDProductionCountry.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/3/25.
//
import Foundation

/// Holds information about a country from The Movie Database.
open class TMDProductionCountry: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The country code.
    public var iso3166_1: String
    
    /// The country name.
    public var name: String

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }

    // MARK: - Initializers
    /// Create a new instance.
    /// - Parameters:
    ///   - iso3166_1: The country code.
    ///   - name: The country name.
    public init(iso3166_1: String, name: String) {
        self.iso3166_1 = iso3166_1
        self.name = name
    }
}
