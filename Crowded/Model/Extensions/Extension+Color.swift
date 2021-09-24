//
//  Extension+Color.swift
//  Crowded
//
//  Created by Blain Ellis on 23/09/2021.
//

import UIKit

extension UIColor {
    
    static func lightTextColor() -> UIColor {
        return #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    static func darkTextColor() -> UIColor {
        return #colorLiteral(red: 0.02022366143, green: 0.03400618655, blue: 0.02071806246, alpha: 1)
    }
    
    static func lightGreyColor() -> UIColor {
        return #colorLiteral(red: 0.4549019608, green: 0.4588235294, blue: 0.4745098039, alpha: 1)
    }
    
    static func darkGreyColor() -> UIColor {
        return #colorLiteral(red: 0.2431372549, green: 0.2470588235, blue: 0.2588235294, alpha: 1)
    }
    
    static func redBarColor() -> UIColor {
        return #colorLiteral(red: 0.937254902, green: 0.3254901961, blue: 0.3098039216, alpha: 1)
    }
    
    static func yellowBarColor() -> UIColor {
        return #colorLiteral(red: 1, green: 0.8745098039, blue: 0.5725490196, alpha: 1)
    }
    
    static func greenBarColor() -> UIColor {
        return #colorLiteral(red: 0.6117647059, green: 0.8, blue: 0.3960784314, alpha: 1)
    }
        
    static func whiteColor() -> UIColor {
        return #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.968627451, alpha: 1)
    }
    
    class func getDarkGreyColor(_ alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(hex: 0x313940, alpha: alpha)
    }
    
    convenience init(hex: Int, alpha:CGFloat) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
}
