//
//  Address.swift
//  Crowded
//
//  Created by Blain Ellis on 23/09/2021.
//

import Foundation

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
