//
//  TMDExternalID.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 6/2/25.
//

import Foundation
import SimpleSerializer

/// Defines a collection of external IDs  used by The Movie Database.
public enum TMDExternalID: String, SimpleSerializeableEnum {
    
    /// An IMDB external ID.
    case imdb = "imdb_id"
    
    /// A Facebook external ID.
    case facebook = "facebook_id"
    
    /// An Instagram external ID.
    case instagram = "instagram_id"
    
    /// A TheTVDB external ID.
    case tvdb = "tvdb_id"
    
    /// A TikTok external ID.
    case tiktok = "tiktok_id"
    
    /// A Twitter (x) external ID.
    case twitter = "twitter_id"
    
    /// A WikiData external ID.
    case wikidata = "wikidata_id"
    
    /// A YouTube external ID.
    case youtube = "youtube_id"
}
