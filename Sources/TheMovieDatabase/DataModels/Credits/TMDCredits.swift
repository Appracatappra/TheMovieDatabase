//
//  TMDCredits.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/29/25.
//
import Foundation
import LogManager

/// Holds information about media credits read from The Movie Database.
public class TMDCredits: Codable {
    
    // MARK: - Static Functions
    /// Gets the credits for the given ID.
    /// - Parameter creditID: The ID to get the credits for.
    /// - Returns: Returns the credits or `nil` if unable to load.
    public static func getCredits(creditID:Int) async -> TMDCredits? {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getDetails(dataType: .credit, dataID: creditID, media: .any)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDCredits.self, from: data)
            
            // Return results
            return results
        } catch {
            // Log error
            Debug.error(subsystem: "TMDCredits", category: "getCredits", "An unexpected error occurred: \(error)")
            
            // Return an empty on error.
            return nil
        }
    }
    
    // MARK: - Properties
    /// The credit type.
    public var creditType: String
    
    /// The credit department.
    public var department: String
    
    /// The unique credit ID.
    public var id: String
    
    /// The job type.
    public var job: String
    
    /// The media for this credit.
    public var media: TMDMedia
    
    /// The media type.
    public var mediaType: String
    
    /// The person this credit belongs to.
    public var person: TMDPerson

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case creditType = "credit_type"
        case department, id, job, media
        case mediaType = "media_type"
        case person
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - creditType: The credit type.
    ///   - department: The credit department.
    ///   - id: The unique credit ID.
    ///   - job: The job type.
    ///   - media: The media for this credit.
    ///   - mediaType: The media type.
    ///   - person: The person this credit belongs to.
    public init(creditType: String, department: String, id: String, job: String, media: TMDMedia, mediaType: String, person: TMDPerson) {
        self.creditType = creditType
        self.department = department
        self.id = id
        self.job = job
        self.media = media
        self.mediaType = mediaType
        self.person = person
    }
}
