//
//  TMDUserList.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//
import Foundation
import LogManager

/// Holds information about a user's list from The Movie Database.
open class TMDUserList: Codable, @unchecked Sendable {
    /// An array of media items in a list.
    public typealias mediaItems = [TMDMedia]
    
    // MARK: - Static Functions
    /// Adds the given media to a list.
    /// - Parameters:
    ///   - listID: The ID of the list to add media to.
    ///   - media: The type of media being added to the list.
    ///   - mediaID: The ID of the media to add.
    /// - Returns: Returns `true` if successful, else returns `false`.
    public static func addMedia(listID:Int, media:TMDMediaType, mediaID:Int) async -> Bool {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let result = try await TMDEndpoint.addToList(listID: listID, media: media, mediaID: mediaID)
            
            // Return results
            return result
        } catch {
            // Log error
            Debug.error(subsystem: "TMDUserList", category: "addMedia", "An unexpected error occurred: \(error)")
            
            // Return failure
            return false
        }
    }
    
    /// Removes a media item from a list.
    /// - Parameters:
    ///   - listID: The list ID to remove the media from.
    ///   - media: The type of media.
    ///   - mediaID: The media ID.
    /// - Returns: Returns `true` if the list was adjusted, else returns `false` on failure.
    public static func removeMedia(listID:Int, media:TMDMediaType, mediaID:Int) async -> Bool {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let result = try await TMDEndpoint.removeFromList(listID: listID, media: media, mediaID: mediaID)
            
            // Return results
            return result
        } catch {
            // Log error
            Debug.error(subsystem: "TMDUserList", category: "removeMedia", "An unexpected error occurred: \(error)")
            
            // Return failure
            return false
        }
    }
    
    /// Checks to see if a media item is in a list.
    /// - Parameters:
    ///   - listID: The ID of the list to check.
    ///   - media: The type of media to check for.
    ///   - mediaID: The ID of the media item to check for.
    ///   - language: The language to check in.
    /// - Returns: Returns `true` if the item is in the list or `false` if the item is not or if an invalid type is checked.
    public static func isItemInList(listID:Int, media:TMDMediaType, mediaID:Int, language: String = "en-US") async -> Bool {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let result = try await TMDEndpoint.isItemInList(listID: listID, media: media, mediaID: mediaID, language: language)
            
            // Return results
            return result
        } catch {
            // Log error
            Debug.error(subsystem: "TMDUserList", category: "isItemInList", "An unexpected error occurred: \(error)")
            
            // Return failure
            return false
        }
    }
    
    /// Clears all items from the given list.
    /// - Parameters:
    ///   - listID: The ID of the list to clear items from.
    ///   - confirm: If `true` confirm the deletion.
    /// - Returns: Returns `true` if successful or `false` on error.
    public static func clearList(listID:Int, confirm:Bool = false) async -> Bool {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let result = try await TMDEndpoint.clearList(listID: listID, confirm: confirm)
            
            // Return results
            return result
        } catch {
            // Log error
            Debug.error(subsystem: "TMDUserList", category: "clearList", "An unexpected error occurred: \(error)")
            
            // Return failure
            return false
        }
    }
    
    /// Creates a new user list.
    /// - Parameters:
    ///   - name: The name of the list to create.
    ///   - description: The new list's description.
    /// - Returns: Returns the ID of the newly created list if successful, else returns `-1` on failure.
    public static func createList(name:String, description:String) async -> Int {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.createList(name: name, description: description)
            
            // Did we receive data?
            guard let data else {
                // No, return error.
                return -1
            }
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDListResult.self, from: data)
            
            // Was the operation successful?
            guard results.success else {
                // No, return error.
                return -1
            }
            
            // Return results
            return results.listID
        } catch {
            // Log error
            Debug.error(subsystem: "TMDUserList", category: "createList", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return -1
        }
    }
    
    /// Deletes the given user list.
    /// - Parameter listID: The ID of the list to delete.
    /// - Returns: Returns `true` if successful or `false` on error.
    public static func deleteList(listID:Int) async -> Bool {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let result = try await TMDEndpoint.deleteList(listID: listID)
            
            // Return results
            return result
        } catch {
            // Log error
            Debug.error(subsystem: "TMDUserList", category: "clearList", "An unexpected error occurred: \(error)")
            
            // Return failure
            return false
        }
    }
    
    /// Gets the details and contents of a user list.
    /// - Parameters:
    ///   - listID: The ID of the list to get the contents of.
    ///   - page: The page to load. The default is 1.
    ///   - language: The language to get the items in. The default is "en-US".
    /// - Returns: Returns the list is successful, else returns `nil`.
    public static func getlist(listID:Int, page:Int = 1, language:String = "en-US") async -> TMDUserList? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getListContents(listID: listID, page: page, language: language)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDUserList.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDUserList", category: "getList", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// The list description.
    public var description: String
    
    /// The list favorite count.
    public var favoriteCount: Int
    
    /// The unique list ID.
    public var id: Int
    
    /// The collection of media items in the list.
    public var items: mediaItems?
    
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
        case items
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
    public init(description: String, favoriteCount: Int, id: Int, items: mediaItems?, itemCount: Int, iso639_1: String, listType: String, name: String, posterPath: String?) {
        
        // Initialize.
        self.description = description
        self.favoriteCount = favoriteCount
        self.id = id
        self.items = items
        self.itemCount = itemCount
        self.iso639_1 = iso639_1
        self.listType = listType
        self.name = name
        self.posterPath = posterPath
    }
}
