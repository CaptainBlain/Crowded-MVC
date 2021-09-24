//
//  BusinessHeaderTableViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class BusinessHeaderTableViewCell: UITableViewCell {

    static let identifier = "BusinessHeaderTableViewCell"
    
    var business: Business!{
        didSet {
            layoutSubviews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.text = business.businessName.capitalized
        tagLabel.text = business.tagString
        descTextView.text = business.businessDesc
    }
}
