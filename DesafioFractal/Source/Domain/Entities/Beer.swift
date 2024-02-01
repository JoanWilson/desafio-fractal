//
//  Beer.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import Foundation

struct Beer: Codable {
    let id: Int
    let name: String
    let tagline: String
    let description: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case description
        case imageURL = "image_url"
    }
}
