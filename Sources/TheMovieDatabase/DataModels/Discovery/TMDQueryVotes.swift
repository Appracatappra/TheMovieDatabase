//
//  TMDQueryVotes.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/30/25.
//

import Foundation
import SimpleSerializer

/// Holds an instance of a votes query used in a The Movie Database query.
open class TMDQueryVotes: Codable, SimpleSerializeable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The average vote greate than.
    public var voteAverageGreaterThan: String = ""
    
    /// The average vote less than.
    public var voteAverageLessThan: String = ""
    
    /// The vote count greate than.
    public var voteCountGreaterThan: String = ""
    
    /// The vote count less than.
    public var voteCountLessThan: String = ""
    
    // MARK: - Computed Properties
    /// Returns the `TMDQueryVotes` as a serialized string.
    public var serialized: String {
        let serializer = Serializer(divider: TMDSerializerDivider.vote)
            .append(voteAverageGreaterThan)
            .append(voteAverageLessThan)
            .append(voteCountGreaterThan)
            .append(voteCountLessThan)
        
        return serializer.value
    }
    
    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - voteAverageGreaterThan: The average vote greate than.
    ///   - voteAverageLessThan: The average vote less than.
    ///   - voteCountGreaterThan: The vote count greate than.
    ///   - voteCountLessThan: The vote count less than.
    public init(voteAverageGreaterThan: String = "", voteAverageLessThan: String = "", voteCountGreaterThan: String = "", voteCountLessThan: String = "") {
        
        self.voteAverageGreaterThan = voteAverageGreaterThan
        self.voteAverageLessThan = voteAverageLessThan
        self.voteCountGreaterThan = voteCountGreaterThan
        self.voteCountLessThan = voteCountLessThan
    }
    
    /// Creates a new instance from a serialized string.
    /// - Parameter value: The serialized string representing the `TMDQueryVotes`.
    public required init(from value: String) {
        let deserializer = Deserializer(text: value, divider: TMDSerializerDivider.vote)
        
        self.voteAverageGreaterThan = deserializer.string()
        self.voteAverageLessThan = deserializer.string()
        self.voteCountGreaterThan = deserializer.string()
        self.voteCountLessThan = deserializer.string()
    }
    
}
