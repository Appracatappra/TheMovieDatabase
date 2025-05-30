//
//  TMDMonitizationType.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/30/25.
//

import Foundation
import SimpleSerializer

/// Defines a collection of watch monitization types used by The Movie Database.
public enum TMDMonitizationType: String, SimpleSerializeableEnum {
    
    /// Any monitization type.
    case any = ""
    
    /// Flat rate monitization.
    case flatrate = "flatrate"
    
    /// Watch for free.
    case free = "free"
    
    /// Add supported content.
    case ads = "ads"
    
    /// Rent to watch.
    case rent = "rent"
    
    /// Purchase to watch.
    case buy = "buy"
}
