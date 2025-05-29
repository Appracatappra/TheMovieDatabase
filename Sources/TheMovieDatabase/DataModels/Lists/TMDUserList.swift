//
//  TMDUserList.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

/// Holds information about a user's list from The Movie Database.
open class TMDUserList: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The list description.
    public var description: String
    
    /// The list favorite count.
    public var favoriteCount: Int
    
    /// The unique list ID.
    public var id: Int
    
    /// The number of items in the list.
    public var itemCount: Int
    
    /// The language code.
    public var iso639_1: String
    
    /// The list type.
    public var listType: String
    
    /// The list name.
    public var name: String
    
    /// An optional list poster path.
    public var posterPath: String?

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case description
        case favoriteCount = "favorite_count"
        case id
        case itemCount = "item_count"
        case iso639_1 = "iso_639_1"
        case listType = "list_type"
        case name
        case posterPath = "poster_path"
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - description: The list description.
    ///   - favoriteCount: The favorite count.
    ///   - id: The unique list ID.
    ///   - itemCount: The number of items in the list.
    ///   - iso639_1: The list language code.
    ///   - listType: The list type.
    ///   - name: The list name.
    ///   - posterPath: An optional list poster path.
    public init(description: String, favoriteCount: Int, id: Int, itemCount: Int, iso639_1: String, listType: String, name: String, posterPath: String?) {
        
        // Initialize.
        self.description = description
        self.favoriteCount = favoriteCount
        self.id = id
        self.itemCount = itemCount
        self.iso639_1 = iso639_1
        self.listType = listType
        self.name = name
        self.posterPath = posterPath
    }
}
