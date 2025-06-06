//
//  TMDCollectionType.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/22/25.
//

/// Defines the types of collection that The Movie Database can work with.
public enum TMDCollectionType: String, Codable {
    
    /// The favorites collection.
    case favorites = "favorite"
    
    /// The watchlist collection.
    case watchlist = "watchlist"
    
    /// The rated collection.
    case rated = "rated"
    
    /// The user's list collection.
    case list = "lists"
    
    /// The changes list.
    case changes = "changes"
    
    /// A collection.
    case collection = "collection"
    
    /// A keyword based collection.
    case keyword = "keyword"
    
    /// A now playing collection.
    case nowPlaying = "now_playing"
    
    /// A collection of popular media.
    case popular = "popular"
    
    /// A collection of top rated media.
    case topRated = "top_rated"
    
    /// A collection of upcoming media.
    case upcoming = "upcoming"
}
