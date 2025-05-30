//
//  TMDReleaseType.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/30/25.
//

import Foundation
import SimpleSerializer

/// Defines a collection of release types used by The Movie Database.
public enum TMDReleaseType: String, SimpleSerializeableEnum {
    
    /// Use any release type.
    case any = ""
    
    /// The release is a premiere.
    case premiere = "1"
    
    /// A limited theatrical release.
    case theatricalLimited = "2"
    
    /// A theatrical release.
    case theatrical = "3"
    
    /// A digital release.
    case digital = "4"
    
    /// Released to physical media.
    case physical = "5"
    
    /// Broadcast on television.
    case tv = "6"
}
