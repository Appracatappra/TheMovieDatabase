//
//  TMDSortOrder.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/22/25.
//

/// Holds the available sort orders for The Movie Database lists.
public enum TMDSortOrder: String, Codable {
    
    /// Sort the items in the list ascending. This is the default.
    case Ascending = "created_at.asc"
    
    /// Sort the items in the list descending.
    case Descending = "created_at.desc"
}
