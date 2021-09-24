//
//  OpeningTimes.swift
//  Crowded
//
//  Created by Blain Ellis on 23/09/2021.
//

import Foundation

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
