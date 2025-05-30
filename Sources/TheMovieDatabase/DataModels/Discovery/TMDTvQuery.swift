//
//  TMDTvQuery.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/30/25.
//

import Foundation
import SimpleSerializer

/// Holds an instance of a certificataion query used in a The Movie Database query.
open class TMDTvQuery: Codable, SimpleSerializeable, @unchecked Sendable {
    
    // MARK: - Properties
    /// Holds a collection of air date queries.
    public var airDates: TMDQueryAirDates = TMDQueryAirDates()
    
    /// If `true` include adult content. If `false` exclude adult content.
    public var includeAdult: Bool = false
    
    /// The language code to query in.
    public var language: String = "en-US"
    
    /// If `true` query shows that were screened theatrically. If `false` query shows that were not screened theatrically.
    public var screenedTheatrically: Bool = false
    
    /// The sort field and direction.
    public var sortBy: TMDSortBy = .none
    
    /// The timezone to query.
    public var timezone: String = ""
    
    /// Holds a collection of vote queries.
    public var votes: TMDQueryVotes = TMDQueryVotes()
    
    /// Holds the watch region.
    /// - Remark: Use in conjunction with `with_watch_monetization_types` or `with_watch_providers`.
    public var watchRegion: String = ""
    
    /// Holds a collection of with queries.
    public var with: TMDQueryWith = TMDQueryWith()
    
    /// Holds a collection of without queries.
    public var without: TMDQueryWithout = TMDQueryWithout()
    
    // MARK: - Computed Properties
    /// Returns the `TMDTvQuery` as a serialized string.
    public var serialized: String {
        let serializer = Serializer(divider: TMDSerializerDivider.query)
            .append(airDates)
            .append(includeAdult)
            .append(language)
            .append(screenedTheatrically)
            .append(sortBy)
            .append(timezone)
            .append(votes)
            .append(watchRegion)
            .append(with)
            .append(without)
        
        return serializer.value
    }
    
    // MARK: - Initializers
    public init(airDates: TMDQueryAirDates = TMDQueryAirDates(), includeAdult: Bool = false, language: String = "en-US", screenedTheatrically: Bool = false, sortBy: TMDSortBy = .none, timezone: String = "", votes: TMDQueryVotes = TMDQueryVotes(), watchRegion: String = "", with: TMDQueryWith = TMDQueryWith(), without: TMDQueryWithout = TMDQueryWithout()) {
        self.airDates = airDates
        self.includeAdult = includeAdult
        self.language = language
        self.screenedTheatrically = screenedTheatrically
        self.sortBy = sortBy
        self.timezone = timezone
        self.votes = votes
        self.watchRegion = watchRegion
        self.with = with
        self.without = without
    }
    
    /// Creates a new instance from a serialized string.
    /// - Parameter value: The serialized string representing the `TMDTvQuery`.
    public required init(from value: String) {
        let deserializer = Deserializer(text: value, divider: TMDSerializerDivider.query)
        
        // Restore self
        self.airDates = deserializer.child()
        self.includeAdult = deserializer.bool()
        self.language = deserializer.string()
        self.screenedTheatrically = deserializer.bool()
        self.sortBy = deserializer.stringEnum()
        self.votes = deserializer.child()
        self.watchRegion = deserializer.string()
        self.with = deserializer.child()
        self.without = deserializer.child()
    }
    
}
