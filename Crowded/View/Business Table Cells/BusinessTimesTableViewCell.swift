//
//  BusinessTimesTableViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 24/09/2021.
//

import UIKit

class BusinessTimesTableViewCell: UITableViewCell {

    static let identifier = "BusinessTimesTableViewCell"
        
    @IBOutlet weak var openingTimesLabel: UILabel!
    @IBOutlet weak var openingTimesDetailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none

    }
    
}
