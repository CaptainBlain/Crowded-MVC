//
//  Extension.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import Firebase
import Toast_Swift

extension DataSnapshot {
    var data: Data? {
        guard let value = value, !(value is NSNull) else { return nil }
        return try? JSONSerialization.data(withJSONObject: value)
    }
    var json: String? { data?.string }
}
extension Data {
    var string: String? { String(data: self, encoding: .utf8) }
}

extension Optional where Wrapped == String {
    
      var isNotEmpty: Bool {
        if self == nil {
            return false
        }
        if !self!.isEmpty {
            return true
        }
        return false
      }
}

extension String {
    
    var isNotEmpty: Bool {
        if !self.isEmpty {
            return true
        }
        return false
    }
    
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
    
    static func helvetica(size: CGFloat) -> UIFont {
        
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    static func helveticaBold(size: CGFloat) -> UIFont {
        
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    static func helveticaMedium(size: CGFloat) -> UIFont {
        
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
}

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

extension NSAttributedString {
    
    static func getFontWithColour(font: UIFont, color: UIColor, textAlignment: NSTextAlignment = NSTextAlignment.left) -> Dictionary<NSAttributedString.Key, Any> {
        
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        
        return [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.paragraphStyle: style]
        
    }
    
    static func getFont(font: UIFont) -> Dictionary<NSAttributedString.Key, Any> {
        
        return [NSAttributedString.Key.font: font]
    }
    
    static func getColour(color: UIColor) -> Dictionary<NSAttributedString.Key, Any> {
        
        return [NSAttributedString.Key.foregroundColor: color]
    }
    
}

extension ToastStyle {
    
    static func getSuccessStyle() -> ToastStyle {
        var style = ToastStyle()
        style.activityBackgroundColor = UIColor.black
        style.titleColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        style.titleFont = UIFont.KailasaBold(16)
        style.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        style.messageColor = UIColor(named: "caliestaGreen")!
        return style
    }
    
    static func getErrorStyle() -> ToastStyle {
        var style = ToastStyle()
        style.titleColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        style.titleFont = UIFont.KailasaBold(14)
        style.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        style.messageColor = UIColor(named: "traderSoupRed")!
        return style
    }
}


extension UIViewController {
    
    func showError(_ message: String, okButtonPressed: (() -> Void)?) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
            if (okButtonPressed != nil) {
                okButtonPressed!()
            }
        }
        alertVC.addAction(okButton)
        
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    func postErrorToast(_ message: String) {
        if let navView = self.navigationController?.view {
            navView.makeToast(message, duration: 3.0, position: .bottom, style: ToastStyle.getErrorStyle())
        }
        else {
        self.view.makeToast(message, duration: 3.0, position: .bottom, style: ToastStyle.getErrorStyle())
        }
    }
    
    func postSuccessToast(_ message: String) {
         // hud.show(in: self.navigationController?.view ?? self.view)
        if let navView = self.navigationController?.view {
            navView.makeToast(message, duration: 3.0, position: .bottom, style: ToastStyle.getSuccessStyle())
        }
        else {
            self.view.makeToast(message, duration: 3.0, position: .bottom, style: ToastStyle.getSuccessStyle())
        }
        
        
    }
    
    func getCustomNavButton(title: String, selector: Selector) -> UIBarButtonItem {
        
        let textAttributesSelected: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.darkTextColor() as Any,
            .font : UIFont.KailasaRegular(18.0) as Any
        ]
        
        let publishButton = UIButton(frame: CGRect(x: 0, y: 10, width: 34, height: 15))
        publishButton.setAttributedTitle(NSAttributedString(string: title, attributes: textAttributesSelected), for: .normal)
        publishButton.addTarget(self, action: selector, for: .touchUpInside)
        return UIBarButtonItem(customView: publishButton)
        
    }
    
    func getCustomBackButton(selector: Selector) -> UIBarButtonItem {
        
        let textAttributesSelected: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.darkTextColor() as Any,
            .font : UIFont.KailasaRegular(18.0) as Any
        ]
        
        let publishButton = UIButton(frame: CGRect(x: 0, y: 10, width: 54, height: 15))
        //publishButton.backgroundColor = .red
        publishButton.setImage(UIImage(named: "back_arrow"), for: .normal)
        
        publishButton.setAttributedTitle(NSAttributedString(string: " Back", attributes: textAttributesSelected), for: .normal)
        publishButton.addTarget(self, action: selector, for: .touchUpInside)
        publishButton.titleLabel?.textAlignment = .right
        return UIBarButtonItem(customView: publishButton)
        
    }
    
   
    func showConfirmAlert(title: String = "Alert", message: String, confirmAction: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button0 = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in })
        let button3 = UIAlertAction(title: "Yes", style: .default, handler: { action in confirmAction() })
        
        alert.addAction(button0)
        alert.addAction(button3)
        present(alert, animated: true)
    }
    
    func showYesNoAlert(title: String = "Alert", message: String, confirmAction: @escaping () -> Void, denyAction: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonNo = UIAlertAction(title: "No", style: .cancel, handler: { action in denyAction()})
        let button3 = UIAlertAction(title: "Yes", style: .default, handler: { action in confirmAction() })
        
       
        alert.addAction(button3)
        alert.addAction(buttonNo)
        present(alert, animated: true)
    }
    
    func showOkAlert(title: String = "Alert", message: String) {
        
        let alertController = UIAlertController(title: NSLocalizedString(title, comment: ""), message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showOkAlert(title: String = "Alert", message: String, confirmAction: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "Ok", style: .default, handler: { action in confirmAction() })
        alert.addAction(button)
        present(alert, animated: true)
    }
    
}

