//
//  TMDGenre.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/2/25.
//

/// Holds information about a genre from The Movie Database.
open class TMDGenre: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The unique genre ID.
    public var id: Int
    
    /// The genre name.
    public var name: String

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - id: The unique genre ID.
    ///   - name: The genre name.
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
