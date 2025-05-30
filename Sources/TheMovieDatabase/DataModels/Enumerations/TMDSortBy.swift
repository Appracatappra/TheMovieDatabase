//
//  TMDSortBy.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/30/25.
//
import Foundation
import SimpleSerializer

/// Defines a set of list sorts that can be used with The Movie Database.
public enum TMDSortBy: String, SimpleSerializeableEnum {
    
    /// Don't sort the list.
    case none = ""
    
    /// Sort by original title ascending.
    case originalTitleAsc = "original_title.asc"
    
    /// Sort by original title descending.
    case originalTitleDesc = "original_title.desc"
    
    /// Sort by popularity ascending.
    case popularityAsc = "popularity.asc"
    
    /// Sort by popularity descending.
    case popularityDesc = "popularity.desc"
    
    /// Sort by revenue ascending.
    case revenueAsc = "revenue.asc"
    
    /// Sort by revenue descending.
    case revenueDesc = "revenue.desc"
    
    /// Sort by primary release date ascending.
    case primaryReleaseDateAsc = "primary_release_date.asc"
    
    /// Sort by primary release date descending.
    case primaryReleaseDateDesc = "primary_release_date.desc"
    
    /// Sort by title ascending.
    case titleAsc = "title.asc"
    
    /// Sort by title descending.
    case titleDesc = "title.desc"
    
    /// Sort by average vote ascending.
    case voteAverageAsc = "vote_average.asc"
    
    /// Sort by average vote descending.
    case voteAverageDesc = "vote_average.desc"
    
    /// Sort by vote count ascending.
    case voteCountAsc = "vote_count.asc"
    
    /// Sort by vote count descending.
    case voteCountDesc = "vote_count.desc"
}
