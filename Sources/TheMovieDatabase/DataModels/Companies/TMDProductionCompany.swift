//
//  TMDProductionCompany.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/3/25.
//
import Foundation

/// Holds information about a production company from The Movie Database.
open class TMDProductionCompany: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    public var id: Int
    public var logoPath: String
    public var name: String
    public var originCountry: String

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }

    // MARK: - Initializers
    public init(id: Int, logoPath: String, name: String, originCountry: String) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
}
