//
//  FBBusinessModel.swift
//  Crowded
//
//  Created by Blain Ellis on 03/12/2020.
//

import Foundation

protocol Business {
    var id: String { get }
    var businessName: String { get }
    var images: BusinessImage { get }
    var tags: [String] { get }
    var settings: Settings { get }
    var featured: Bool { get }
}

extension Business {
    var tagString: String {
        return tags.joined(separator: " - ")
    }
}

