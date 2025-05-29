//
//  TMDQueryDates.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/29/25.
//

import Foundation
import SimpleSerializer

/// Holds an instance of a date range query used in a The Movie Database query.
open class TMDQueryDates: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The primary release year.
    /// - remark: In the form "1984".
    public var primaryReleaseYear: String = ""
    
    /// The primary release date greater than.
    /// - remark: In the form "1984-01-02" repersenting January 2nd, 1984  (YYYY-MM-DD).
    public var primaryReleaseDateGreaterThan: String = ""
    
    /// The primary release date less than.
    /// - remark: In the form "1984-01-02" repersenting January 2nd, 1984  (YYYY-MM-DD).
    public var primaryReleaseDateLessThan: String = ""
    
    /// The release date greater than.
    /// - remark: In the form "1984-01-02" repersenting January 2nd, 1984  (YYYY-MM-DD).
    public var releaseDateGreaterThan: String = ""
    
    // The release date less than.
    /// - remark: In the form "1984-01-02" repersenting January 2nd, 1984  (YYYY-MM-DD).
    public var releaseDateLessThan: String = ""
    
    /// The release year.
    /// - remark: In the form "1984".
    public var year: String = ""
    
    // MARK: - Computed Properties
    /// Returns the `TMDQueryDates` as a serialized string.
    var serialized:String {
        let serializer = Serializer(divider: TMDSerializerDivider.dates)
            .append(primaryReleaseYear)
            .append(primaryReleaseDateGreaterThan)
            .append(primaryReleaseDateLessThan)
            .append(releaseDateGreaterThan)
            .append(releaseDateLessThan)
            .append(year)
        
        return serializer.value
    }
    
    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - primaryReleaseYear: The primary release year.
    ///   - primaryReleaseDateGreaterThan: The primary release date greater than.
    ///   - primaryReleaseDateLessThan: The primary release date less than.
    ///   - releaseDateGreaterThan: The release date greater than.
    ///   - releaseDateLessThan: The release date less than.
    ///   - year: The release year.
    public init(primaryReleaseYear: String = "", primaryReleaseDateGreaterThan: String = "", primaryReleaseDateLessThan: String = "", releaseDateGreaterThan: String = "", releaseDateLessThan: String = "", year: String = "") {
        
        // Initialize.
        self.primaryReleaseYear = primaryReleaseYear
        self.primaryReleaseDateGreaterThan = primaryReleaseDateGreaterThan
        self.primaryReleaseDateLessThan = primaryReleaseDateLessThan
        self.releaseDateGreaterThan = releaseDateGreaterThan
        self.releaseDateLessThan = releaseDateLessThan
        self.year = year
    }
    
    /// Creates a new instance from a serialized string.
    /// - Parameter value: The serialized string representing the `TMDQueryDates`.
    public init(from value:String) {
        let deserializer = Deserializer(text: value, divider: TMDSerializerDivider.dates)
        
        self.primaryReleaseYear = deserializer.string()
        self.primaryReleaseDateGreaterThan = deserializer.string()
        self.primaryReleaseDateLessThan = deserializer.string()
        self.releaseDateGreaterThan = deserializer.string()
        self.releaseDateLessThan = deserializer.string()
        self.year = deserializer.string()
    }
}
