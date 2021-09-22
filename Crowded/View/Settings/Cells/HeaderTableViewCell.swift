//
//  HeaderTableViewCell.swift
//  caliesta-business
//
//  Created by Blain Ellis on 08/02/2020.
//  Copyright © 2020 caliesta. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    static let identifier = "HeaderTableViewCellIdentifier"
    
    @IBOutlet weak var cellLabel: UILabel!
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
        
        if let cellLabelTitle = cellLabelTitle {
            cellLabel.text = cellLabelTitle
        }
    }
    
}
