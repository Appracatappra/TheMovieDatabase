//
//  TMDCompany.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

import Foundation
import LogManager

/// Holds the details of a company from The Movie Database.
open class TMDCompany: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets the company details from The Movie Database.
    /// - Parameters:
    ///   - companyID: The company ID.
    /// - Returns: Returns the company details or `nil` if unable to load.
    public static func getCompany(companyID:Int) async -> TMDCompany? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getDetails(dataType: .company, dataID: companyID)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDCompany.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDCompany", category: "getCompany", "An unexpected error occurred: \(error)")
            
            // Return empty token
            return nil
        }
    }
    
    // MARK: - Properties
    /// The company description.
    public var description: String
    
    /// The company headquarters.
    public var headquarters: String
    
    /// The company homepage.
    public var homepage: String
    
    /// The unique company ID.
    public var id: Int
    
    /// The optional logo path.
    public var logoPath: String?
    
    /// The company name.
    public var name: String
    
    /// The optional company origin.
    public var originCountry: String?
    
    /// The optional company parent.
    public var parentCompany: String?

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case description, headquarters, homepage, id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
        case parentCompany = "parent_company"
    }

    // MARK: - Initializers.
    /// Creates a new instance.
    /// - Parameters:
    ///   - description: The company description.
    ///   - headquarters: The company headquarters.
    ///   - homepage: The company homepage.
    ///   - id: The unique company ID.
    ///   - logoPath: The optional logo path.
    ///   - name: The company name.
    ///   - originCountry: The optional company origin.
    ///   - parentCompany: The optional company parent.
    public init(description: String, headquarters: String, homepage: String, id: Int, logoPath: String?, name: String, originCountry: String?, parentCompany: String?) {
        self.description = description
        self.headquarters = headquarters
        self.homepage = homepage
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
        self.parentCompany = parentCompany
    }
}
