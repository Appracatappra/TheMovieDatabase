//
//  TMDShowType.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/30/25.
//

import Foundation
import SimpleSerializer

/// Defines a collection of release types used by The Movie Database.
public enum TMDShowType: String, SimpleSerializeableEnum {
    
    /// Any show type.
    case any = ""
    
    /// All show types.
    case all = "0"
    
    /// A tv series.
    case series = "1"
    
    /// A tv miniseries.
    case miniseries = "2"
    
    /// A tv movie.
    case tvMovie = "3"
    
    /// A tv short series.
    case shortSeries = "4"
    
    /// A tv special.
    case tvSpecial = "5"
    
    /// A tv documentary.
    case tvDocumentary = "6"
}
