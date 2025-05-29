//
//  TMDMediaType.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/22/25.
//

/// Defines the type of media that The Movie Database can work with.
public enum TMDMediaType: String, Codable {
    
    /// A non-specified media type.
    case any = ""
    
    /// The media is a movie.
    case movie = "movie"
    
    /// The media is a movie collection.
    case movies = "movies"
    
    /// The media is a television show.
    case tvShow = "tv"
    
    /// The media is a television show episode.
    case tvEpisode = "tv/episodes"
    
    /// The media is a person in the entertainment industry.
    case person = "person"
    
    /// The media is a collection of people in the industry.
    case people = "people"
    
    /// The media is an image.
    case images = "images"
    
    /// The media is a translation.
    case translations = "translations"
    
    /// The media is a list of alternative names.
    case alternativeNames = "alternative_names"
    
    /// The media is a collection of country codes.
    case countries = "countries"
    
    /// The media is a list of jobs.
    case jobs = "jobs"
    
    /// The media is a list of languages.
    case languages = "languages"
    
    /// The media is a list of primary translations.
    case primaryTranslations = "primary_translations"
    
    /// The media is a list of timezones.
    case timezones = "timezones"
}
