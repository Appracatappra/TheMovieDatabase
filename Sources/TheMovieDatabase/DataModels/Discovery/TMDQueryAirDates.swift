//
//  TMDQueryAirDates.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/30/25.
//

import Foundation
import SimpleSerializer

/// Holds an instance of a date range query used in a The Movie Database query.
open class TMDQueryAirDates: Codable, SimpleSerializeable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The air date greater than.
    public var airDateGreaterThan: String = ""
    
    /// The air date less than.
    public var airDateLessThan: String = ""
    
    /// The first air date year.
    public var firstAirDateYear: String = ""
    
    /// The first air date greater than.
    public var firstAirDateGreaterThan: String = ""
    
    /// The first air date less than.
    public var firstAirDateLessThan: String = ""
    
    /// If `true` include media with null air dates. If `false` include media with null air dates.
    public var includeNullAirDates: Bool = false
    
    // MARK: - Computed Properties
    public var serialized: String {
        let serializer = Serializer(divider: TMDSerializerDivider.dates)
            .append(airDateGreaterThan)
            .append(airDateLessThan)
            .append(firstAirDateYear)
            .append(firstAirDateGreaterThan)
            .append(firstAirDateLessThan)
            .append(includeNullAirDates)
        
        return serializer.value
    }
    
    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - airDateGreaterThan: The air date greater than.
    ///   - airDateLessThan: The air date less than.
    ///   - firstAirDateYear: The first air date year.
    ///   - firstAirDateGreaterThan: The first air date greater than.
    ///   - firstAirDateLessThan: The first air date greater than.
    ///   - includeNullAirDates: The first air date less than.
    public init(airDateGreaterThan: String = "", airDateLessThan: String = "", firstAirDateYear: String = "", firstAirDateGreaterThan: String = "", firstAirDateLessThan: String = "", includeNullAirDates: Bool = false) {
        
        self.airDateGreaterThan = airDateGreaterThan
        self.airDateLessThan = airDateLessThan
        self.firstAirDateYear = firstAirDateYear
        self.firstAirDateGreaterThan = firstAirDateGreaterThan
        self.firstAirDateLessThan = firstAirDateLessThan
        self.includeNullAirDates = includeNullAirDates
    }
    
    /// Creates a new instance from a serialized string.
    /// - Parameter value: The serialized string representing the `TMDQueryDates`.
    required public init(from value:String) {
        let deserializer = Deserializer(text: value, divider: TMDSerializerDivider.dates)
        
        self.airDateGreaterThan = deserializer.string()
        self.airDateLessThan = deserializer.string()
        self.firstAirDateYear = deserializer.string()
        self.firstAirDateGreaterThan = deserializer.string()
        self.firstAirDateLessThan = deserializer.string()
        self.includeNullAirDates = deserializer.bool()
    }
    
}
