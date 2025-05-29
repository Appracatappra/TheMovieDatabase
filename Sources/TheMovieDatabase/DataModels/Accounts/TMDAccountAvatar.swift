//
//  Avatar.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/21/25.
//

// Holds information about the TMD User's Avatar.
open class TMDAccountAvatar: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The Gravatar address for the user's icon.
    public var gravatar: TMDGravatar
    
    /// The TMD address for the user's icon.
    public var tmdb: TMDAvatar

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - gravatarHash: The gravatar hash for the icon to display.
    ///   - avatarPath: The avatar path.
    public init(gravatarHash:String, avatarPath:String) {
        
        // Initialize.
        self.gravatar = TMDGravatar(hash: gravatarHash)
        self.tmdb = TMDAvatar(avatarPath: avatarPath)
    }
    
    /// Creates a new instance.
    /// - Parameters:
    ///   - gravatar: The Gravatar address for the user's icon.
    ///   - tmdb: The TMD address for the user's icon.
    public init(gravatar: TMDGravatar, tmdb: TMDAvatar) {
        self.gravatar = gravatar
        self.tmdb = tmdb
    }
}
