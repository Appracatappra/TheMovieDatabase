//
//  TMDResponseFailure.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/22/25.
//

// Holds information about a result sent from The Movie Database.
open class TMDResponseFailure: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// If `true` the action was successful. If `false` the action failed.
    public var success: Bool
    
    /// The status code for the action.
    public var statusCode: Int
    
    /// The message for the action.
    public var statusMessage: String

    // MARK: - Coding Keys
    /// The coding keys for the class.
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - success: If `true` the action was successful. If `false` the action failed.
    ///   - statusCode: The status code for the action.
    ///   - statusMessage: The message for the action.
    public init(success: Bool, statusCode: Int, statusMessage: String) {
        self.success = success
        self.statusCode = statusCode
        self.statusMessage = statusMessage
    }
}
