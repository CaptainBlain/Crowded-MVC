//
//  BusinessLocationTableViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class BusinessLocationTableViewCell: UITableViewCell {

    static let identifier = "BusinessLocationTableViewCellId"
    
    var business: Business!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
  
    @IBOutlet weak var openingTimesLabel: UILabel!
    @IBOutlet weak var openingTimesDetailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        cityLabel.text = business.businessAddress.city.capitalized
        addressLabel.text = business.businessAddress.addressString
        
        openingTimesDetailsLabel.text = business.openingTimes.openingTimesString
        
    }
    
}
