//
//  HTTPBodyBuilder.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/22/25.
//

import Foundation

/// Helpr class to assemble a HTTP Body for sending to a RESTful API.
open class HTTPBodyBuilder {
    
    // MARK: - Properties
    /// The contents of the builder.
    public var contents:String = ""
    
    /// Any parameters to send to the
    public var parameters:[URLParameter] = []
    
    // MARK: - Computed Properties
    /// Returns the contens with all of the parameters expanded.
    public var dataString:String {
        // Get the contents.
        var data = contents
        
        // Insert all of the parameters.
        for parameter in parameters {
            data = data.replacingOccurrences(of: "<\(parameter.name)>", with: parameter.value)
        }
        
        // Return the contents with the parameters.
        return data
    }
    
    /// Returns the contents as UTF8 encoded data.
    public var data:Data? {
        return dataString.data(using: .utf8)
    }
    
    // MARK: - Initializers
    /// Creates a new instance.
    public init() {
            
    }
    
    /// Creates a new instance.
    /// - Parameter contents: The HTTP Body that will be sent to a RESTful API endpoint..
    public init(_ contents:String = "") {
        
        // Initialize
        self.contents = contents
    }
    
    // MARK: - Functions
    /// Adds a `URLParameter` to this builder.
    /// - Parameter parameter: The parameter to add.
    /// - Returns: Returns self.
    @discardableResult public func addParameter(_ parameter:URLParameter) -> HTTPBodyBuilder {
        self.parameters.append(parameter)
        
        return self
    }
    
    /// Adds a parameter to this builder.
    /// - Parameters:
    ///   - name: The name of the parameter to add.
    ///   - Value: The value for the parameter.
    /// - Returns: Returns self.
    @discardableResult public func addParameter(name:String, Value:String) -> HTTPBodyBuilder {
        let parameter:URLParameter = URLParameter(name: name, value: Value)
        
        return self.addParameter(parameter)
    }
    
    /// Adds a parameter to this builder.
    /// - Parameters:
    ///   - name: The name of the parameter to add.
    ///   - Value: The value for the parameter.
    /// - Returns: Returns self.
    @discardableResult public func addParameter(name:String, Value:Int) -> HTTPBodyBuilder {
        let parameter:URLParameter = URLParameter(name: name, value: "\(Value)")
        
        return self.addParameter(parameter)
    }
    
    /// Adds a parameter to this builder.
    /// - Parameters:
    ///   - name: The name of the parameter to add.
    ///   - Value: The value for the parameter.
    /// - Returns: Returns self.
    @discardableResult public func addParameter(name:String, Value:Bool) -> HTTPBodyBuilder {
        let text = Value ? "true" : "false"
        let parameter:URLParameter = URLParameter(name: name, value: "\(text)")
        
        return self.addParameter(parameter)
    }
    
    /// Adds a parameter to this builder.
    /// - Parameters:
    ///   - name: The name of the parameter to add.
    ///   - Value: The value for the parameter.
    /// - Returns: Returns self.
    @discardableResult public func addParameter(name:String, Value:Float) -> HTTPBodyBuilder {
        let parameter:URLParameter = URLParameter(name: name, value: "\(Value)")
        
        return self.addParameter(parameter)
    }
}
