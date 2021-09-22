//
//  BusinessContactTableViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class BusinessContactTableViewCell: UITableViewCell {

    static let identifier = "BusinessContactTableViewCellId"
    
    @IBOutlet weak var dropShadowView: UIView!
    
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var websiteLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var websiteDetailsLabel: UILabel!
    
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var contactLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
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
            
            let website = business.contact.website
            websiteLabel.text = "Website"
            if website.isEmpty {
                websiteLabel.text = ""
                websiteLabelHeightConstraint.constant = 0
            }
            websiteDetailsLabel.text = website
            
            let phone = business.contact.phone
            let email = business.contact.email
            contactLabel.text = "Contact"
            if phone.isEmpty && email.isEmpty {
                contactLabel.text = ""
                contactLabelHeightConstraint.constant = 0
            }
            phoneNumberLabel.text = phone
            emailLabel.text = email
        }
    }

}
