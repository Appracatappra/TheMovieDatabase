//
//  TMDName.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

/// Holds information about a name from The Movie Database.
open class TMDName: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The name value.
    public var name: String
    
    /// The name type.
    public var type: String

    //  MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - name: The name value.
    ///   - type: The name type.
    public init(name: String, type: String) {
        self.name = name
        self.type = type
    }
}
