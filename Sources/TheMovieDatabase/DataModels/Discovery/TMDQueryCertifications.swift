//
//  TMDQueryCertifications.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/29/25.
//
import Foundation
import SimpleSerializer

/// Holds an instance of a certificataion query used in a The Movie Database query.
open class TMDQueryCertifications: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// Holds a certification that the media must conform to.
    /// - remark: Use in conjunction with region.
    public var certification: String = ""
    
    /// Holds the starting certification that the media must conform to.
    /// - remark: Use in conjunction with region.
    public var certificationGreaterThan: String = ""
    
    /// Holds the ending certification that the media must conform to.
    /// - remark: Use in conjunction with region.
    public var certificationLessThan: String = ""
    
    /// Holds a certification country that the media must conform to.
    /// - remark: Use in conjunction with region.
    public var certificationCountry: String = ""
    
    // MARK: - Computed Properties
    /// Returns the `TMDQueryCertifications` as a serialized string.
    var serialized:String {
        let serializer = Serializer(divider: TMDSerializerDivider.certifications)
            .append(certification)
            .append(certificationGreaterThan)
            .append(certificationLessThan)
            .append(certificationCountry)
        
        return serializer.value
    }
    
    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - certification: Holds a certification that the media must conform to.
    ///   - certificationGreaterThan: Holds the starting certification that the media must conform to.
    ///   - certificationLessThan: Holds the ending certification that the media must conform to.
    ///   - certificationCountry: Holds a certification country that the media must conform to.
    /// - remark: Set any parameter to Empty String ("") to omit from the query.
    public init(certification: String = "", certificationGreaterThan: String = "", certificationLessThan: String = "", certificationCountry: String = "") {
        
        // Initialize.
        self.certification = certification
        self.certificationGreaterThan = certificationGreaterThan
        self.certificationLessThan = certificationLessThan
        self.certificationCountry = certificationCountry
    }
    
    /// Creates a new instance from a serialized string.
    /// - Parameter value: The serialized string representing the `TMDQueryCertifications`.
    public init(from value:String) {
        let deserializer = Deserializer(text: value, divider: TMDSerializerDivider.certifications)
        
        self.certification = deserializer.string()
        self.certificationGreaterThan = deserializer.string()
        self.certificationLessThan = deserializer.string()
        self.certificationCountry = deserializer.string()
    }
}
