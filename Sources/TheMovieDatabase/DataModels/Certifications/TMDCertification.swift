//
//  TMDCertification.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

import Foundation

/// Holds a certification entry from The Movie Database.
open class TMDCertification: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The code for the certification.
    public var certification: String
    
    /// The certification meaning.
    public var meaning: String
    
    /// The sort order for the certification.
    public var order: Int

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - certification: he code for the certification.
    ///   - meaning: The certification meaning.
    ///   - order: The sort order for the certification.
    public init(certification: String, meaning: String, order: Int) {
        
        // Initialize.
        self.certification = certification
        self.meaning = meaning
        self.order = order
    }
}
