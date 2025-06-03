//
//  TMDDateRange.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/3/25.
//
import Foundation

/// Holds a date range from The Movie Database.
open class TMDDateRange: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The largest date in the range.
    public var maximum: String
    
    /// The smallest date in the range.
    public var minimum: String

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - maximum: The largest date in the range.
    ///   - minimum: The smallest date in the range.
    public init(maximum: String, minimum: String) {
        self.maximum = maximum
        self.minimum = minimum
    }
}
