//
//  URLBuilder.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/21/25.
//

import Foundation

open class URLBuilder {
    
    // MARK: - Properties
    /// The URL Address of the RESTful API endpoint.
    public var urlEndpoint:String = ""
    
    /// Any parameters to send to the
    public var parameters:[URLParameter] = []
    
    // MARK: - Computed Properties
    /// Gets the URL Address String.
    public var urlString:String {
        // Assemble the base call and include the apiKey.
        var url = "\(urlEndpoint)?api_key=\(TMDConfiguration.apiKey)"
        
        // Include any parameters in the string.
        for parameter in self.parameters {
            url += "&\(parameter.name)=\(parameter.value.urlEncoded)"
        }
        
        // Return the generated URL String.
        return url
    }
    
    /// Gets the URL represented by this builder.
    public var url:URL? {
        return URL(string: self.urlString)
    }
    
    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameter urlEndpoint: The URL Address of the RESTful API endpoint.
    public init(_ urlEndpoint:String = "") {
        
        // Initialize
        self.urlEndpoint = urlEndpoint
    }
    
    // MARK: - Functions
    /// Adds the given parameter to the path if it is not empty.
    /// - Parameter parameter: The parameter to add.
    /// - Returns: Returns self.
    @discardableResult public func addPathParameter(parameter:String) -> URLBuilder {
        
        // Anything to append?
        guard parameter.isEmpty == false else {
            // No, return
            return self
        }
        
        // Add parameter
        urlEndpoint += "/\(parameter)"
        
        return self
    }
    
    /// Adds a `URLParameter` to this builder.
    /// - Parameter parameter: The parameter to add.
    /// - Returns: Returns self.
    @discardableResult public func addParameter(_ parameter:URLParameter) -> URLBuilder {
        self.parameters.append(parameter)
        
        return self
    }
    
    /// Adds a parameter to this builder.
    /// - Parameters:
    ///   - name: The name of the parameter to add.
    ///   - Value: The value for the parameter.
    /// - Returns: Returns self.
    @discardableResult public func addParameter(name:String, value:String) -> URLBuilder {
        
        // Anything to append?
        guard value.isEmpty == false else {
            // No, return
            return self
        }
        
        let parameter:URLParameter = URLParameter(name: name, value: value)
        
        return self.addParameter(parameter)
    }
    
    /// Adds a parameter to this builder.
    /// - Parameters:
    ///   - name: The name of the parameter to add.
    ///   - Value: The value for the parameter.
    /// - Returns: Returns self.
    @discardableResult public func addParameter(name:String, value:Int) -> URLBuilder {
        let parameter:URLParameter = URLParameter(name: name, value: "\(value)")
        
        return self.addParameter(parameter)
    }
    
    /// Adds a parameter to this builder.
    /// - Parameters:
    ///   - name: The name of the parameter to add.
    ///   - Value: The value for the parameter.
    /// - Returns: Returns self.
    @discardableResult public func addParameter(name:String, value:Bool) -> URLBuilder {
        let text = value ? "true" : "false"
        let parameter:URLParameter = URLParameter(name: name, value: "\(text)")
        
        return self.addParameter(parameter)
    }
    
    /// Adds a parameter to this builder.
    /// - Parameters:
    ///   - name: The name of the parameter to add.
    ///   - Value: The value for the parameter.
    /// - Returns: Returns self.
    @discardableResult public func addParameter(name:String, value:Float) -> URLBuilder {
        let parameter:URLParameter = URLParameter(name: name, value: "\(value)")
        
        return self.addParameter(parameter)
    }
}
