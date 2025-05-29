//
//  TMDDataType.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

/// Holds a data type that can be requested from The Movie Database.
public enum TMDDataType: String, Codable {
    
    /// Represents certification data.
    case certification = "certification"
    
    /// Represents change data.
    case changes = ""
    
    /// Represents company data.
    case company = "company"
    
    /// Represents configuration data.
    case configuration = "configuration"
}
