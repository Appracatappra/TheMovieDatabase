//
//  Gravatar.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/21/25.
//

/// Holds information about a TMD Gravatar image.
open class TMDGravatar: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The Gravatar hash for the image.
    public var hash: String

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameter hash: The Gravatar hash for the image.
    public init(hash: String) {
        self.hash = hash
    }
}
