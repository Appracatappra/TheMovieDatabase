//
//  TMDListResult.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/3/25.
//

import Foundation
import LogManager

/// Holds the result of a list interaction from The Movie Database.
open class TMDListResult: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The status message.
    public var statusMessage:String
    
    /// If `true` the operation was successful. If `false`, it failed.
    public var success:Bool
    
    /// The status code.
    public var statusCode:Int
    
    /// The list ID.
    public var listID:Int
    
    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case success
        case statusCode = "status_code"
        case listID = "list_id"
    }
    
    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - statusMessage: The status message.
    ///   - success: If `true` the operation was successful. If `false`, it failed.
    ///   - statusCode: The status code.
    ///   - listID: The list ID.
    public init(statusMessage: String, success: Bool, statusCode: Int, listID: Int) {
        self.statusMessage = statusMessage
        self.success = success
        self.statusCode = statusCode
        self.listID = listID
    }
}
