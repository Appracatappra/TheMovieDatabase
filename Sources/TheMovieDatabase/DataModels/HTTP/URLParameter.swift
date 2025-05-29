//
//  URLParameter.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/21/25.
//

/// Holds information about a URL parameter.
open class URLParameter {
    
    // MARK: - Properties
    /// Holds the parameter name.
    public var name:String = ""
    
    /// Holds the parameter value.
    public var value:String = ""
    
    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - name: The name of the parameter.
    ///   - value: The value of the parameter.
    public init(name:String, value:String) {
        self.name = name
        self.value = value
    }
    
}
