//
//  TextFieldTableViewCell.swift
//  caliesta-business
//
//  Created by Blain Ellis on 01/11/2019.
//  Copyright © 2019 caliesta. All rights reserved.
//

import UIKit

protocol TextFieldTableViewCellDelegate: AnyObject {
    func textFieldTableViewCellBeginEditing(forIndexPath indexPath: IndexPath)
    func textFieldTableViewCellDidUpdateText(text: String, forIndexPath indexPath: IndexPath)
}

protocol TextFieldTableViewCellTableLayoutDelegate: AnyObject {
    func textFieldTableViewCellBeginEditing(forTableViewLayout tableViewLayout: TableViewLayout)
    func textFieldTableViewCellDidUpdateText(text: String, tableViewLayout: TableViewLayout)
    func textFieldTableViewCellEndEditing(forTableViewLayout tableViewLayout: TableViewLayout)
}

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "TextFieldTableViewCellIdentifier"
    
    private let textAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor : UIColor(named: "textFieldPlaceholder") as Any,
        .font : UIFont.helvetica(size: 17.0) as Any
    ]
    private let placeholderAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor : UIColor(named: "textFieldPlaceholder") as Any,
        .font : UIFont.helvetica(size: 17.0) as Any
    ]
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellTextField: UITextField!
    
    
    //Public
    weak var delegate: TextFieldTableViewCellDelegate?
   var indexPath: IndexPath!
    
    weak var tableLayoutDelegate: TextFieldTableViewCellTableLayoutDelegate?
    var tableViewLayout: TableViewLayout?
    
    var textFieldPlaceholder: String?
    var textFieldText: String?    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        
        cellTextField.delegate = self
        cellTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 20))
        cellTextField.leftViewMode = .always
        cellTextField.returnKeyType = UIReturnKeyType.done
        cellTextField.layer.cornerRadius = 4
        cellTextField.autocapitalizationType = .words
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellTextField.keyboardType = .default
        cellTextField.autocapitalizationType = .sentences
        
        cellTextField.attributedPlaceholder = NSAttributedString(string: "")
        cellTextField.text = ""
        
                
        let placeholderText = textFieldPlaceholder.isNotEmpty ? textFieldPlaceholder : ""
                
        cellLabel.text = ""
        cellTextField.placeholder = placeholderText
        
        if let textFieldText = textFieldText {
            cellLabel.text = placeholderText
            cellTextField.text = textFieldText
            if textFieldText.isEmpty {
                cellLabel.text = ""
            }
        }
    }
    

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.textFieldTableViewCellBeginEditing(forIndexPath: indexPath)
        if let tableViewLayout = tableViewLayout {
            self.tableLayoutDelegate?.textFieldTableViewCellBeginEditing(forTableViewLayout: tableViewLayout)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            //textFieldText = updatedText;
            
            self.delegate?.textFieldTableViewCellDidUpdateText(text: updatedText, forIndexPath: indexPath)
            
                let placeholderText = textFieldPlaceholder.isNotEmpty ? textFieldPlaceholder : ""
                cellLabel.text = placeholderText
                if updatedText.isEmpty {
                    cellLabel.text = ""
                }
            
            
            if let tableViewLayout = tableViewLayout {
                self.tableLayoutDelegate?.textFieldTableViewCellDidUpdateText(text: updatedText, tableViewLayout: tableViewLayout)
            }

        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let tableViewLayout = tableViewLayout {
            self.tableLayoutDelegate?.textFieldTableViewCellEndEditing(forTableViewLayout: tableViewLayout)
        }
        return true
    }
    
}
