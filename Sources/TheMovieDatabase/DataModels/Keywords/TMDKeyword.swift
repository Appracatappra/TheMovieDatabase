//
//  TMDKeyword.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/2/25.
//
import Foundation
import LogManager

/// Holds information about a keyword from The Movie Database.
open class TMDKeyword: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets the keyword details.
    /// - Parameter keywordID: The keyword to get details for.
    /// - Returns: Returns the keyword details or `nil` if unable to load.
    public static func getKeyword(keywordID:Int) async -> TMDKeyword? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getDetails(dataType: .keyword, dataID: keywordID, includeSession: false)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDKeyword.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDKeyword", category: "getKeyword", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// The unique keyword ID.
    public var id: Int
    
    /// The keyword name.
    public var name: String

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - id: The unique keyword ID.
    ///   - name: The keyword name.
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
