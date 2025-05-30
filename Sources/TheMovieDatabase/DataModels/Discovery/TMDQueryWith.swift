//
//  TMDQueryWith.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/30/25.
//

import Foundation
import SimpleSerializer

/// Holds an instance of a "with" query used in a The Movie Database query.
open class TMDQueryWith: Codable, SimpleSerializeable, @unchecked Sendable {
    
    // MARK: - Properties
    /// Including cast members.
    /// - Remark: Can be a comma (AND) or pipe (OR) separated query.
    public var cast:String = ""
    
    /// Including companies.
    /// - Remark: Can be a comma (AND) or pipe (OR) separated query.
    public var companies:String = ""
    
    /// Including crew.
    /// - Remark: Can be a comma (AND) or pipe (OR) separated query.
    public var crew:String = ""
    
    /// Including genres codes.
    /// - Remark: Can be a comma (AND) or pipe (OR) separated query.
    public var genres:String = ""
    
    /// Including keywords..
    /// - Remark: Can be a comma (AND) or pipe (OR) separated query.
    public var keywords:String = ""
    
    /// Including country of origin.
    public var originCountry:String = ""
    
    /// Include original language.
    public var originalLanguage:String = ""
    
    /// Including people.
    /// - Remark: Can be a comma (AND) or pipe (OR) separated query.
    public var people:String = ""
    
    /// Include a specific release type.
    public var releaseType:TMDReleaseType = .any
    
    /// Include runtime longer than.
    public var runtimeGreaterThan:String = ""
    
    /// Include runtime less than.
    public var runtimeLessThan:String = ""
    
    /// Include monitization type.
    public var monitization:TMDMonitizationType = .any
    
    /// Including watch providers.
    /// - Remark: Can be a comma (AND) or pipe (OR) separated query.
    public var watchProviders:String = ""
    
    /// Including netwroks.
    /// - Remark: Can be a comma (AND) or pipe (OR) separated query.
    public var networks:String = ""
    
    /// Include tv show status.
    public var status: TMDMediaStatus = .any
    
    /// Include tv show type.
    public var showType: TMDShowType = .any
    
    // MARK: - Computed Properties
    /// Returns the `TMDQueryWith` as a serialized string.
    public var serialized: String {
        let serializer = Serializer(divider: TMDSerializerDivider.with)
            .append(cast)
            .append(companies)
            .append(crew)
            .append(genres)
            .append(keywords)
            .append(originCountry)
            .append(originalLanguage)
            .append(people)
            .append(releaseType)
            .append(runtimeGreaterThan)
            .append(runtimeLessThan)
            .append(monitization)
            .append(watchProviders)
            .append(networks)
            .append(status)
            .append(showType)
        
        return serializer.value
    }
    
    // MARK: - Inititalizers
    /// Creates a new instance.
    /// - Parameters:
    ///   - cast: Including cast members.
    ///   - companies: Including companies.
    ///   - crew: Including crew.
    ///   - genres: Including genres codes.
    ///   - keywords: Including keywords..
    ///   - originCountry: Including country of origin.
    ///   - originalLanguage: Include original language.
    ///   - people: Including people.
    ///   - releaseType: Include a specific release type.
    ///   - runtimeGreaterThan: Include runtime longer than.
    ///   - runtimeLessThan: Include runtime less than.
    ///   - monitization: Include monitization type.
    ///   - watchProviders: Including watch providers.
    ///   - networks: Include networks.
    ///   - status: Include tv show status.
    ///   - showType: Include tv show type.
    public init(cast:String = "", companies:String = "", crew:String = "", genres:String = "", keywords:String = "", originCountry:String = "", originalLanguage:String = "", people:String = "", releaseType:TMDReleaseType = .any, runtimeGreaterThan:String = "", runtimeLessThan:String = "", monitization:TMDMonitizationType = .any, watchProviders:String = "", networks:String = "", status: TMDMediaStatus = .any, showType: TMDShowType = .any) {
        
        self.cast = cast
        self.companies = companies
        self.crew = crew
        self.genres = genres
        self.keywords = keywords
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.people = people
        self.releaseType = releaseType
        self.runtimeGreaterThan = runtimeGreaterThan
        self.runtimeLessThan = runtimeLessThan
        self.monitization = monitization
        self.watchProviders = watchProviders
        self.networks = networks
        self.status = status
        self.showType = showType
    }
    
    /// Creates a new instance from a serialized string.
    /// - Parameter value: The serialized string representing the `TMDQueryWith`.
    public required init(from value: String) {
        let deserializer = Deserializer(text: value, divider: TMDSerializerDivider.with)
        
        self.cast = deserializer.string()
        self.companies = deserializer.string()
        self.crew = deserializer.string()
        self.genres = deserializer.string()
        self.keywords = deserializer.string()
        self.originCountry = deserializer.string()
        self.originalLanguage = deserializer.string()
        self.people = deserializer.string()
        self.releaseType = deserializer.stringEnum()
        self.runtimeGreaterThan = deserializer.string()
        self.runtimeLessThan = deserializer.string()
        self.monitization = deserializer.stringEnum()
        self.watchProviders = deserializer.string()
        self.networks = deserializer.string()
        self.status = deserializer.stringEnum()
        self.showType = deserializer.stringEnum()
    }
    
}
