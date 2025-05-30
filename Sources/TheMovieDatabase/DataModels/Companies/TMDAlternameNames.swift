//
//  TMDAlternameNames.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

import Foundation
import LogManager

/// Holds a collection of company alternate names from The Movie Database.
open class TMDAlternameNames: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets a list of alternate names for a company.
    /// - Parameters:
    ///   - companyID: The company ID.
    /// - Returns: Returns the lsit of names or `nil` if unable to load.
    public static func getCompanyNames(companyID:Int) async -> TMDAlternameNames? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getDetails(dataType: .company, dataID: companyID, media: .alternativeNames)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDAlternameNames.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDAlternameNames", category: "getCompanyNames", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// The unique ID.
    public var id: Int
    
    /// The list of names.
    public var results: [TMDName]

    // MARK: - Initializers.
    /// Creates a new instance.
    /// - Parameters:
    ///   - id: The unique ID.
    ///   - results: The list of names.
    public init(id: Int, results: [TMDName]) {
        self.id = id
        self.results = results
    }
}
