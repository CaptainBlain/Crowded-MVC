//
//  Settings.swift
//  Crowded
//
//  Created by Blain Ellis on 23/09/2021.
//

import UIKit

struct Settings: Decodable {
    var backgroundColour: String
}

extension Settings {
    func getBackgroundColour() -> UIColor {
        return backgroundColour.hexStringToUIColor
    }
}
