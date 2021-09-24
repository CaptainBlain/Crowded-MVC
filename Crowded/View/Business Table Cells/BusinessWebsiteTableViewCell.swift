//
//  BusinessContactTableViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class BusinessWebsiteTableViewCell: UITableViewCell {

    static let identifier = "BusinessWebsiteTableViewCell"
    
    var business: Business!{
        didSet {
            layoutSubviews()
        }
    }
    
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var websiteDetailsLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        websiteDetailsLabel.text = business.contact.website
        
    }
    
}
