//
//  BusinessImageHeaderTableViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class BusinessImageHeaderTableViewCell: UITableViewCell {

    static let identifier = "BusinessImageHeaderTableViewCell"
    
    var business: Business!{
        didSet {
            layoutSubviews()
        }
    }
    
    @IBOutlet weak var businessImageViewBorder: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
        businessImageViewBorder.layer.cornerRadius = 10
        businessImageViewBorder.clipsToBounds = false
        businessImageViewBorder.layer.shadowColor = UIColor.black.cgColor
        businessImageViewBorder.layer.shadowOpacity = 1
        businessImageViewBorder.layer.shadowOffset = CGSize.zero
        businessImageViewBorder.layer.shadowRadius = 4
        businessImageViewBorder.layer.shadowPath = UIBezierPath(roundedRect: businessImageViewBorder.bounds, cornerRadius: 10).cgPath
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        businessImageViewBorder.backgroundColor = business.settings.backgroundColour.hexStringToUIColor
        bannerImageView.backgroundColor = business.settings.backgroundColour.hexStringToUIColor
        bannerImageView.contentMode = .scaleAspectFill
        
        if let banner = URL(string: business.images.banner) {
            NetworkController.shared.requestImage(banner) { [weak self] image in
                self?.bannerActivityIndicator.stopAnimating()
                self?.bannerImageView.image = image
            }
        }
        
        logoImageView.backgroundColor = business.settings.backgroundColour.hexStringToUIColor
        logoImageView.layer.cornerRadius = 12.0
        logoImageView.contentMode = .scaleAspectFit
        
        if let logo = URL(string: business.images.logo) {
            NetworkController.shared.requestImage(logo) { [weak self] image in
                self?.logoImageView.image = image
            }
        }
    }
}
