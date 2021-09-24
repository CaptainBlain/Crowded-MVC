//
//  Extension+String.swift
//  Crowded
//
//  Created by Blain Ellis on 23/09/2021.
//

import UIKit

extension String {
        
    var hexStringToUIColor: UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func getStringSize(for font: UIFont, andWidth width: CGFloat) -> CGSize {
        
        // calculate text height
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [
                                                NSAttributedString.Key.font: font],
                                            context: nil)
        let width = ceil(boundingBox.width)
        let height = ceil(boundingBox.height)
        
        return CGSize(width: width, height: height)
    }
    
    func appendComma(_ string: String, skip: Bool = false) -> String {
        var commaString = self
        if !string.isEmpty {
            if !self.isEmpty {
                let comma = skip ? " " : ", "
                commaString.append(comma)
            }
            commaString.append(string)
        }
        return commaString
    }
    
}
