//
//  TMDSerializerDivider.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/29/25.
//

/// Holds a collection of serialization dividers for use with the SimpleSerializer library.
enum TMDSerializerDivider:String, Codable {
    case certifications = "~"
    case dates = "!"
    case query = "@"
    case vote = "#"
    case with = "$"
    case without = "%"
}
