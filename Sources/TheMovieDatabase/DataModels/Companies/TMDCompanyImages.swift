//
//  TMDCompanyImages.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

import Foundation
import LogManager

/// Holds a collection of company images read from The Movie Database.
open class TMDCompanyImages: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    public static func getCompanyImages(companyID:Int) async -> TMDCompanyImages? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getDetails(dataType: .company, dataID: companyID, media: .images)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDCompanyImages.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDCompanyImages", category: "getCompanyImages", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// The unique ID.
    public var id: Int
    
    /// The list of logos.
    public var logos: [TMDImage]

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - id: The unique ID.
    ///   - logos: The list of logos.
    public init(id: Int, logos: [TMDImage]) {
        self.id = id
        self.logos = logos
    }
}
