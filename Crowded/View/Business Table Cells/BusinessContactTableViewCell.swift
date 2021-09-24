//
//  BusinessContactTableViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class BusinessContactTableViewCell: UITableViewCell {

    static let identifier = "BusinessContactTableViewCell"
    
    var business: Business!{
        didSet {
            layoutSubviews()
        }
    }
    
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var websiteDetailsLabel: UILabel!
    
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let phone = business.contact.phone
        let email = business.contact.email
        contactLabel.text = "Contact"
        if phone.isEmpty && email.isEmpty {
            contactLabel.text = ""
        }
        phoneNumberLabel.text = phone
        emailLabel.text = email
        
    }
    
}
