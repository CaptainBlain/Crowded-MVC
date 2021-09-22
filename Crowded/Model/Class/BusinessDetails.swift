//
//  BusinessDetails.swift
//  Crowded
//
//  Created by Blain Ellis on 03/12/2020.
//

import Foundation

struct BusinessDetails: Decodable {

    var business: BusinessBase
    var businessDesc: String
    var businessAddress: Address
    var openingTimes: OpeningTimes
    var contact: Contact
}

extension BusinessDetails: Business {
    var id: String {
        business.id
    }
    
    var businessName: String {
        business.businessName
    }
    
    var images: BusinessImage {
        business.images
    }
    
    var tags: [String] {
        business.tags
    }
    
    var settings: Settings {
        business.settings
    }
    
    var featured: Bool {
        business.featured
    }
}

struct Address: Decodable {
    var number: String
    var name: String
    var street: String
    var city: String
    var subLocal: String
    var postcode: String
}
extension Address {
    var addressString: String {
        var address = ""
        address = address.appendComma(name.capitalized)
        address = address.appendComma(number)
        address = address.appendComma(street.capitalized, skip: true)
        address = address.appendComma(subLocal.capitalized)
        address = address.appendComma(postcode)
        return address
    }
}

struct OpeningTimes: Decodable {
    var fullOpeningTimes: String?
}

extension OpeningTimes {
    var openingTimesString: String {
        var openingTimes = ""
        if let fullOpeningTimes = fullOpeningTimes {
            if !fullOpeningTimes.isEmpty {
                openingTimes = fullOpeningTimes
            }
        }
        return openingTimes
    }
}

struct Contact: Decodable {
    var website: String
    var email: String
    var phone: String
}
