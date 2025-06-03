//
//  TMDPresent.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/2/25.
//
import Foundation

/// Holds information about a media item's presence in The Movie Database.
open class TMDPresent: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The media ID.
    public var id: String
    
    /// If `true` the media item is present, else it is not.
    public var itemPresent: Bool

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case id
        case itemPresent = "item_present"
    }

    // MARK: - Initializers.
    /// Creates a new instance.
    /// - Parameters:
    ///   - id: The media ID.
    ///   - itemPresent: If `true` the media item is present, else it is not.
    public init(id: String, itemPresent: Bool) {
        self.id = id
        self.itemPresent = itemPresent
    }
}
