//
//  BusinessLocationTableViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class BusinessLocationTableViewCell: UITableViewCell {

    static let identifier = "BusinessLocationTableViewCellId"
    
    @IBOutlet weak var dropShadowView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
  
    @IBOutlet weak var openingTimesLabel: UILabel!
    @IBOutlet weak var openingTimesDetailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        dropShadowView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.20).cgColor
        dropShadowView.layer.shadowOpacity = 10
        dropShadowView.layer.shadowOffset = .zero
        dropShadowView.layer.shadowRadius = 2
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
            cityLabel.text = business.businessAddress.city.capitalized
            addressLabel.text = business.businessAddress.addressString
            
            openingTimesLabel.text = "Opening Times"
            openingTimesDetailsLabel.text = business.openingTimes.openingTimesString
        }
    }

}
