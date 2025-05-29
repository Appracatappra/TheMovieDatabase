//
//  TMDPerson.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/29/25.
//

/// Holds information about a person from The Movie Database.
open class TMDPerson: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// If `true` this person is associated with adult content, else they are not.
    public var adult: Bool
    
    /// The person's gender code.
    public var gender: Int
    
    /// The person's unique ID.
    public var id: Int
    
    /// The known for department.
    public var knownForDepartment: String
    
    /// The media type.
    public var mediaType: String
    
    /// The person's name.
    public var name: String
    
    /// The person's original name.
    public var originalName: String
    
    /// The person's popularity.
    public var popularity: Double
    
    /// The person's profile path.
    public var profilePath: String

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case mediaType = "media_type"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
    }

    // MARK: - Initializers
    /// Creates a new instance.
    /// - Parameters:
    ///   - adult: If `true` this person is associated with adult content, else they are not.
    ///   - gender: The person's gender code.
    ///   - id: The person's unique ID.
    ///   - knownForDepartment: The known for department.
    ///   - mediaType: The media type.
    ///   - name: The person's name.
    ///   - originalName: The person's original name.
    ///   - popularity: The person's popularity.
    ///   - profilePath: The person's profile path.
    public init(adult: Bool, gender: Int, id: Int, knownForDepartment: String, mediaType: String, name: String, originalName: String, popularity: Double, profilePath: String) {
        self.adult = adult
        self.gender = gender
        self.id = id
        self.knownForDepartment = knownForDepartment
        self.mediaType = mediaType
        self.name = name
        self.originalName = originalName
        self.popularity = popularity
        self.profilePath = profilePath
    }
}
