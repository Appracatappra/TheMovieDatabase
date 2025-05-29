//
//  TMDImage.swift
//  TheMovieDatabase
//
//  Created by Kevin Mullins on 5/28/25.
//

/// Holds information about an image from The Movie Databse.
open class TMDImage: Codable, @unchecked Sendable {
    
    // MARK: - Properties
    /// The aspect ratio.
    public var aspectRatio: Double
    
    /// The file path.
    public var filePath: String
    
    /// The image width.
    public var height: Int
    
    /// The optional unique ID.
    public var id: Int?
    
    /// The image language code.
    public var iso639_1: String?
    
    /// The image filetype.
    public var filetype: String?
    
    /// The average vote.
    public var voteAverage: Double
    
    /// The vote count.
    public var voteCount: Int
    
    /// The image width.
    public var width: Int

    // MARK: - Coding Keys
    /// The coding keys for the class.
    public enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case iso639_1 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }

    // MARK: - Initializers
    public init(aspectRatio: Double, filePath: String, height: Int, id: Int?, iso639_1: String?, fileType: String?, voteAverage: Double, voteCount: Int, width: Int) {
        self.aspectRatio = aspectRatio
        self.filePath = filePath
        self.height = height
        self.id = id
        self.iso639_1 = iso639_1
        self.filetype = fileType
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.width = width
    }
}
