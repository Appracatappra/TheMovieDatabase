//
//  TMDMediaStatus.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/30/25.
//

import Foundation
import SimpleSerializer

/// Defines a collection of release types used by The Movie Database.
public enum TMDMediaStatus: String, SimpleSerializeableEnum {
    
    /// Use any status type.
    case any = ""
    
    /// The show is rumored.
    case rumored = "0"
    
    /// The show is released.
    case released = "1"
    
    /// The show is in post production.
    case postProduction = "2"
    
    /// The show is filming.
    case filming = "3"
    
    /// The show is planned.
    case planned = "4"
    
    /// The show is in production
    case inProduction = "5"
    
}
