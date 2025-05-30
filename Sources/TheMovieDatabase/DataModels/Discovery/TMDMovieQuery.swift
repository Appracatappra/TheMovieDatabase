//
//  TMDMovieQuery.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/30/25.
//

import Foundation
import SimpleSerializer

/// Holds an instance of a certificataion query used in a The Movie Database query.
open class TMDMovieQuery: Codable, SimpleSerializeable, @unchecked Sendable {
    
    // MARK: - Properties
    /// Holds a collection of certifications.
    public var certifications: TMDQueryCertifications = TMDQueryCertifications()
    
    /// If `true` include adult content. If `false` exclude adult content.
    public var includeAdult: Bool = false
    
    /// If `true` include videos. If `false` exclude videos.
    public var includeVideo: Bool = false
    
    /// The language code to query in.
    public var language: String = "en-US"
    
    /// Holds a collection of date ranges used in the query
    public var dates: TMDQueryDates = TMDQueryDates()
    
    /// The region code to query in.
    public var region: String = "US"
    
    /// The sort field and direction.
    public var sortBy: TMDSortBy = .none
    
    /// Holds a collection of vote queries.
    public var votes: TMDQueryVotes = TMDQueryVotes()
    
    /// Holds the watch region.
    /// - Remark: Use in conjunction with `with_watch_monetization_types` or `with_watch_providers`.
    public var watchRegion: String = ""
    
    /// Holds a collection of with queries.
    public var with: TMDQueryWith = TMDQueryWith()
    
    /// Holds a collection of without queries.
    public var without: TMDQueryWithout = TMDQueryWithout()
    
    /// Query for a specifc year.
    public var year: String = ""
    
    // MARK: - Computed Properties
    /// Returns the `TMDMovieQuery` as a serialized string.
    public var serialized: String {
        let serializer = Serializer(divider: TMDSerializerDivider.query)
            .append(certifications)
            .append(includeAdult)
            .append(includeVideo)
            .append(language)
            .append(dates)
            .append(region)
            .append(sortBy)
            .append(votes)
            .append(watchRegion)
            .append(with)
            .append(without)
            .append(year)
        
        return serializer.value
    }
    
    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - certifications: Holds a collection of certifications.
    ///   - includeAdult: If `true` include adult content. If `false` exclude adult content.
    ///   - includeVideo: If `true` include videos. If `false` exclude videos.
    ///   - language: The language code to query in.
    ///   - dates: Holds a collection of date ranges used in the query
    ///   - region: The region code to query in.
    ///   - sortBy: The sort field and direction.
    ///   - votes: Holds a collection of vote queries.
    ///   - watchRegion: Holds the watch region.
    ///   - with: Holds a collection of with queries.
    ///   - without: Holds a collection of without queries.
    ///   - year: Query for a specifc year.
    public init(certifications: TMDQueryCertifications = TMDQueryCertifications(), includeAdult: Bool = false, includeVideo: Bool = false, language: String = "en-US", dates: TMDQueryDates = TMDQueryDates(), region: String = "US", sortBy: TMDSortBy = .none, votes: TMDQueryVotes = TMDQueryVotes(), watchRegion: String = "", with: TMDQueryWith = TMDQueryWith(), without: TMDQueryWithout = TMDQueryWithout(), year: String = "") {
        
        // Initialize
        self.certifications = certifications
        self.includeAdult = includeAdult
        self.includeVideo = includeVideo
        self.language = language
        self.dates = dates
        self.region = region
        self.sortBy = sortBy
        self.votes = votes
        self.watchRegion = watchRegion
        self.with = with
        self.without = without
        self.year = year
    }
    
    /// Creates a new instance from a serialized string.
    /// - Parameter value: The serialized string representing the `TMDMovieQuery`.
    public required init(from value: String) {
        let deserializer = Deserializer(text: value, divider: TMDSerializerDivider.query)
        
        // Restore self
        self.certifications = deserializer.child()
        self.includeAdult = deserializer.bool()
        self.includeVideo = deserializer.bool()
        self.language = deserializer.string()
        self.dates = deserializer.child()
        self.region = deserializer.string()
        self.sortBy = deserializer.stringEnum()
        self.votes = deserializer.child()
        self.watchRegion = deserializer.string()
        self.with = deserializer.child()
        self.without = deserializer.child()
        self.year = deserializer.string()
    }
}
