//
//  FBBusinessModel.swift
//  Crowded
//
//  Created by Blain Ellis on 03/12/2020.
//

import Foundation

struct Business: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case businessName = "businessName"
        case businessDesc = "businessDesc"
        case businessAddress = "businessAddress"
        case openingTimes = "openingTimes"
        case contact = "contact"
        case images
        case tags
        case settings
        case featured
    }
    
    var businessName: String
    var businessDesc: String
    var businessAddress: Address
    var openingTimes: OpeningTimes
    var contact: Contact
    var images: Image
    var tags: [String]
    var settings: Settings
    var featured: Bool
}

extension Business {
    var tagString: String {
        return tags.joined(separator: " - ")
    }
}
