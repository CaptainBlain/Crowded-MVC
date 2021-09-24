//
//  Extension+Font.swift
//  Crowded
//
//  Created by Blain Ellis on 23/09/2021.
//

import UIKit

extension UIFont {
        
    class func KailasaRegular(_ size: CGFloat) -> UIFont {
        
        if let kalisa = UIFont(name: "Kailasa", size: size) {
            return kalisa
        }
        
        return UIFont.systemFont(ofSize: size)
    }
    
    class func KailasaBold(_ size: CGFloat) -> UIFont {
        
        if let kalisa = UIFont(name: "Kailasa-Bold", size: size) {
            return kalisa
        }
        
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    class func helvetica(size: CGFloat) -> UIFont {
        
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    class func helveticaBold(size: CGFloat) -> UIFont {
        
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    class func helveticaMedium(size: CGFloat) -> UIFont {
        
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
}
