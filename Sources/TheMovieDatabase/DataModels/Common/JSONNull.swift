//
//  JSONNull.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/21/25.
//

/// Helper class to handle nulls in a JSON String.
open class JSONNull: Codable, Hashable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Adds equality comparison to `JSONNull`.
    /// - Parameters:
    ///   - lhs: The left side to compare.
    ///   - rhs: The right side to compare.
    /// - Returns: Returns `true` if equal, else returns `false`.
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    // MARK: - Initializers.
    /// Creates a new instance.
    public init() {}
    
    /// Creates a new instance.
    /// - Parameter decoder: The decoder to create the instance from.
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    /// Creates a hash for the null value.
    /// - Parameter hasher: The hasher to use.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
    
    /// Encodes the null value.
    /// - Parameter encoder: The encode to use.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
