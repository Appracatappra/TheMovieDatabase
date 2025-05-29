//
//  TMDJob.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/29/25.
//

import Foundation

/// Holds information about industry jobs used in The Movie Database.
open class TMDJob: Codable, @unchecked Sendable {
    
    // MARK: - Static Functions
    /// Gets the list of jobs.
    /// - Returns: Returns the array of jobs or an empty array if unable to load.
    public static func getJobs() async -> TMDJobs {
        
        // Trap all errors
        do {
            // Get data from The Movie Database.
            let data = try await TMDEndpoint.getDetails(dataType: .configuration, media: .jobs)
            
            // Attempt to read the returned data.
            let results = try JSONDecoder().decode(TMDJobs.self, from: data)
            
            // Return results
            return results
        } catch {
            // Return an empty configuration on error.
            return TMDJobs()
        }
    }
    
    // MARK: - Properties
    /// The department the job belongs to.
    public var department: String
    
    /// The list of jobs in the department.
    public var jobs: [String]

    // MARK: - Constructors
    /// Creates a new empty instance.
    public init() {
        
        // Initialize.
        self.department = ""
        self.jobs = []
    }
    
    /// Creates a new instance.
    /// - Parameters:
    ///   - department: The department the job belongs to.
    ///   - jobs: The list of jobs in the department.
    public init(department: String, jobs: [String]) {
        self.department = department
        self.jobs = jobs
    }
}

/// Holds an array of industry jobs used in The Movie Database.
public typealias TMDJobs = [TMDJob]
