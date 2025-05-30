//
//  TMDQueryWithout.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/30/25.
//

import Foundation
import SimpleSerializer

/// Holds an instance of a "without" query used in a The Movie Database query.
open class TMDQueryWithout: Codable, SimpleSerializeable, @unchecked Sendable {
    
    // MARK: - Properties
    /// Including companies.
    /// - Remark: Can be a comma (AND) or pipe (OR) separated query.
    public var companies:String = ""
    
    /// Including genres.
    /// - Remark: Can be a comma (AND) or pipe (OR) separated query.
    public var genres:String = ""
    
    /// Including keywords..
    /// - Remark: Can be a comma (AND) or pipe (OR) separated query.
    public var keywords:String = ""
    
    /// Including watch providers.
    /// - Remark: Can be a comma (AND) or pipe (OR) separated query.
    public var watchProviders:String = ""
    
    // MARK: - Computed Properties
    /// Returns the `TMDQueryWithout` as a serialized string.
    public var serialized: String {
        let serializer = Serializer(divider: TMDSerializerDivider.without)
            .append(companies)
            .append(genres)
            .append(keywords)
            .append(watchProviders)
        
        return serializer.value
    }
    
    // MARK: - Inititalizers
    /// Creates a new instance.
    /// - Parameters:
    ///   - companies: Including companies.
    ///   - genres: Including genres.
    ///   - keywords: Including keywords..
    ///   - watchProviders: Including watch providers.
    public init(companies:String = "", genres:String = "", keywords:String = "", watchProviders:String = "") {
        
        self.companies = companies
        self.genres = genres
        self.keywords = keywords
        self.watchProviders = watchProviders
    }
    
    /// Creates a new instance from a serialized string.
    /// - Parameter value: The serialized string representing the `TMDQueryWithout`.
    public required init(from value: String) {
        let deserializer = Deserializer(text: value, divider: TMDSerializerDivider.without)
        
        self.companies = deserializer.string()
        self.genres = deserializer.string()
        self.keywords = deserializer.string()
        self.watchProviders = deserializer.string()
    }
    
}
