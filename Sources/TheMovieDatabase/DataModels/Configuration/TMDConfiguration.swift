//
//  TMDConfiguration.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/21/25.
//
// Generated from:
// https://developer.themoviedb.org/reference/intro/getting-started
// https://chisa.mintlify.app/api-reference/account/public-details

import Foundation
import LogManager
import UrlUtilities

/// Holds information about the general system configuration used throughout The Movie Database.
open class TMDConfiguration: Codable, @unchecked Sendable {
    
    // MARK: - Static Properties
    /// Gets the developer's API Key used throughout the app.
    nonisolated(unsafe) public private(set) static var apiKey: String = ""
    
    /// A common shared instance of The Movie Database configurations.
    nonisolated(unsafe) public static var shared: TMDConfiguration = TMDConfiguration()
    
    // MARK: - Static Functions
    /// Sets the API Key used for all The Movie Database endpoint calls.
    /// - Parameter apiKey: The API Key to set.
    public static func setApiKey(_ apiKey: String) {
        
        // Add a default API key to all URLBuilder calls
        URLBuilder.addDefaultParameter(name: "api_key", value: apiKey)
        
        // Save the API Key
        TMDConfiguration.apiKey = apiKey
    }
    
    /// Gets the current configuration from The Movie Database.
    /// - Returns: Returns the configuration or an empty configuration if unable to load.
    public static func getDetails() async -> TMDConfiguration {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getDetails(dataType: .configuration)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDConfiguration.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDConfiguration", category: "getDetails", "An unexpected error occurred: \(error)")
            
            // Return an empty configuration on error.
            return TMDConfiguration()
        }
    }
    
    // MARK: - Properties
    /// Holds a collection of change keys.
    public var changeKeys: [String]
    
    /// Holds information about the image configuration used in The Movie Database.
    public var images: TMDImageConfig
    
    /// Holds a collection of movie certifications.
    public var movieCertifications: TMDCertifications = TMDCertifications()
    
    /// Holds a collection of tv certifications.
    public var tvCertifications: TMDCertifications = TMDCertifications()
    
    /// Holds an array of country codes.
    public var countries: TMDCountries = TMDCountries()
    
    /// Holds an array of jobs.
    public var jobs: TMDJobs = TMDJobs()
    
    /// Holds an array of language codes.
    public var languages: TMDLanguages = TMDLanguages()
    
    /// Holds an array of primary translations.
    public var primaryTranslations: TMDTranslationIndexes = TMDTranslationIndexes()

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case changeKeys = "change_keys"
        case images
    }

    // MARK: - Initializers
    /// Creates a new empty instance.
    public init() {
        
        // Initialize.
        self.changeKeys = []
        self.images = TMDImageConfig()
    }
    
    /// Creates a new instance.
    /// - Parameters:
    ///   - changeKeys: Holds a collection of change keys.
    ///   - images: Holds information about the image configuration used in The Movie Database.
    public init(changeKeys: [String], images: TMDImageConfig) {
        self.changeKeys = changeKeys
        self.images = images
    }
    
    // MARK: - Functions
    /// Attempts to download all of the required configuration details from The Movie Database.
    public func downloadConfigurations() async {
        
        // Get all certifications
        movieCertifications = await TMDCertifications.getCertifications(media: .movie)
        tvCertifications = await TMDCertifications.getCertifications(media: .tvShow)
        
        // Get the country codes.
        countries = await TMDCountry.getCountries()
        
        // Get the job list.
        jobs = await TMDJob.getJobs()
        
        // Get the language list.
        languages = await TMDLanguage.getLanguages()
        
        // Get the primary translations
        primaryTranslations = await TMDTranslationIndex.getTranslationIndexes()
    }
}
