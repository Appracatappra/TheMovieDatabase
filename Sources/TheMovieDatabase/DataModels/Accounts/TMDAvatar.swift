//
//  Tmdb.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/21/25.
//

// Holds the information to locate a TMD avatar.
open class TMDAvatar: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The avatar path.
    public var avatarPath: String?

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameter avatarPath: The avatar path.
    public init(avatarPath: String?) {
        self.avatarPath = avatarPath
    }
}
