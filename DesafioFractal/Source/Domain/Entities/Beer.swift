//
//  Beer.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import Foundation

public struct Beer: Codable, Equatable {
    let id: Int
    let name: String
    let tagline: String
    let description: String
    let imageURL: String?
    
    public init(id: Int, name: String, tagline: String, description: String, imageURL: String?) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.description = description
        self.imageURL = imageURL
    }
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case description
        case imageURL = "image_url"
    }
}
