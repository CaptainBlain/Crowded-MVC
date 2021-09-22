//
//  BusinessHeaderTableViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class BusinessHeaderTableViewCell: UITableViewCell {

    static let identifier = "BusinessHeaderTableViewCellId"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descLabelHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var business: BusinessDetails? {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let business = business {
            titleLabel.text = business.businessName.capitalized
            tagLabel.text = business.tagString
            descLabel.text = business.businessDesc
        }
    }
}
