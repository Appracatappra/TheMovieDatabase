//
//  TMDMediaIndex.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

/// Holds an index to a piece of media from The Movie Database.
open class TMDMediaIndex: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// If `true` the media is NSFW Adult content. If `false` it's not adult content.
    public var adult: Bool?
    
    /// The ID of the media being referenced.
    public var id: Int

    // MARK: - Initializers
    /// Create a new instance.
    /// - Parameters:
    ///   - adult: If `true` the media is NSFW Adult content. If `false` it's not adult content.
    ///   - id: The ID of the media being referenced.
    public init(adult: Bool?, id: Int) {
        self.adult = adult
        self.id = id
    }
}
