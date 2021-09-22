//
//  TextViewTableViewCell.swift
//  caliesta-business
//
//  Created by Blain Ellis on 01/11/2019.
//  Copyright © 2019 caliesta. All rights reserved.
//

import UIKit

protocol TextViewTableViewCellDelegate: AnyObject {
    func textViewTableViewCellBeginEditing(forIndexPath indexPath: IndexPath)
    func textViewTableViewCellDidUpdateText(text: String, forIndexPath indexPath: IndexPath)
}

protocol TextViewTableViewCellTableViewLayoutDelegate: AnyObject {
    func textViewTableViewCellBeginEditing(forTableViewLayout tableViewLayout: TableViewLayout)
    func textViewTableViewCellDidUpdateText(text: String, tableViewLayout: TableViewLayout)
}

class TextViewTableViewCell: UITableViewCell, UITextViewDelegate {
    
    static let identifier = "TextViewTableViewCellldentifier"
    
    private let textAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor : UIColor(named: "textFieldPlaceholder") as Any,
        .font : UIFont.helvetica(size: 17.0) as Any
    ]
    
    @IBOutlet weak var cellTextView: UITextView!
    
    weak var tableLayoutDelegate: TextViewTableViewCellTableViewLayoutDelegate?
    var tableViewLayout: TableViewLayout?
    
    weak var delegate: TextViewTableViewCellDelegate?
    var indexPath: IndexPath!
    
    var textFieldPlaceholder: String?
    var textViewText: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        
        cellTextView.delegate = self
        cellTextView.layer.cornerRadius = 4
        cellTextView.font = UIFont.KailasaRegular(17.0)
        cellTextView.contentInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        cellTextView.autocapitalizationType = .sentences
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellTextView.text = ""
        cellTextView.text = textFieldPlaceholder
        cellTextView.textColor = UIColor(named: "textFieldPlaceholder")
        
        
        if let textViewText = textViewText {
            if !textViewText.isEmpty {
                cellTextView.text = textViewText
                cellTextView.textColor = UIColor(named: "textFieldText")
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.delegate?.textViewTableViewCellBeginEditing(forIndexPath: indexPath)
        
        if let tableViewLayout = tableViewLayout {
            self.tableLayoutDelegate?.textViewTableViewCellBeginEditing(forTableViewLayout: tableViewLayout)
        }
        
        if textView.textColor == UIColor(named: "textFieldPlaceholder") {
            textView.text = nil
            textView.textColor = UIColor(named: "textFieldText")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textFieldPlaceholder
            textView.textColor = UIColor(named: "textFieldPlaceholder")
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        self.delegate?.textViewTableViewCellDidUpdateText(text: newText, forIndexPath: indexPath)
        
        if let tableViewLayout = tableViewLayout {
            self.tableLayoutDelegate?.textViewTableViewCellDidUpdateText(text: newText, tableViewLayout: tableViewLayout)
        }
                
        return true
    }
    
}
