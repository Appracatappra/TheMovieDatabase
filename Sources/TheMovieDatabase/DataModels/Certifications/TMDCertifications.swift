//
//  TMDCertifications.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

import Foundation
import LogManager

/// Holds a collection of certifications from The Movie Database.
open class TMDCertifications: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets a dictionary of certififcation for the given media type.
    /// - Parameters:
    ///   - media: The type of media to return certifications for.
    /// - Returns: Returns the requested certifications or an empty set of certifications if unable to load.
    public static func getCertifications(media:TMDMediaType) async -> TMDCertifications {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getList(dataType: .certification, media: media, collection: .list)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDCertifications.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDCertifications", category: "getCertifications", "An unexpected error occurred: \(error)")
            
            // Return empty
            return TMDCertifications()
        }
    }
    
    // MARK: - Porperties
    /// A dictionary of certifications by Country Code.
    public var certifications: [String: [TMDCertification]]

    // MARK: - Initializers
    /// Creates a new empty instance.
    public init() {
        
        // Initialize.
        self.certifications = [:]
    }
    
    /// Creates a new instance.
    /// - Parameter certifications: A dictionary of certifications by Country Code.
    public init(certifications: [String: [TMDCertification]]) {
        self.certifications = certifications
    }
}
