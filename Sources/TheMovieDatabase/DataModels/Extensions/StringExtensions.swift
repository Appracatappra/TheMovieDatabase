//
//  StringExtensions.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/21/25.
//

import Foundation

public extension String {
    
    /// Returns the string encoded to pass into a URL.
    var urlEncoded:String {
        let encodedString = addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        return encodedString.replacingOccurrences(of: "&", with: "%26")
    }
}
