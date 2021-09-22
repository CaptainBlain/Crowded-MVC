//
//  Business.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import Foundation

struct BusinessBase: Business {
    var id: String
    var businessName: String
    var images: BusinessImage
    var tags: [String]
    var settings: Settings
    var featured: Bool
}

extension BusinessBase: Decodable {
    
}

struct BusinessImage: Decodable {
    var logo: String
    var banner: String
}

struct Settings: Decodable {
    var backgroundColour: String
}
