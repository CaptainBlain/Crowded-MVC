//
//  DetailsTableViewCell.swift
//  caliesta-business
//
//  Created by Blain Ellis on 08/02/2020.
//  Copyright © 2020 caliesta. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    static let identifier = "DetailsTableViewCellIdentifier"
    
    @IBOutlet weak var cellLabel: UILabel!
    
    var cellLabelPlaceholder: String?
    var cellLabelTitle: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let placeholder = cellLabelPlaceholder {
            cellLabel.text = placeholder
            cellLabel.textColor = UIColor(named: "textFieldPlaceholder")
            cellLabel.font = UIFont.KailasaRegular(15.0)
        }
        
        if cellLabelTitle.isNotEmpty {
            cellLabel.text = cellLabelTitle
            cellLabel.textColor = UIColor(named: "darkText")
            cellLabel.font = UIFont.KailasaRegular(17.0)
        }
    }
    
}
