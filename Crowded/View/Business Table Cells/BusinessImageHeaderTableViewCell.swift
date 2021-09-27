//
//  BusinessImageHeaderTableViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class BusinessImageHeaderTableViewCell: UITableViewCell {

    static let identifier = "BusinessImageHeaderTableViewCell"
    
    var banner: String = "" {
        didSet {
            layoutSubviews()
        }
    }
    
    var logo: String = "" {
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
        
        businessImageViewBorder.layer.cornerRadius = 10
        businessImageViewBorder.clipsToBounds = false
        businessImageViewBorder.layer.shadowColor = UIColor.black.cgColor
        businessImageViewBorder.layer.shadowOpacity = 1
        businessImageViewBorder.layer.shadowOffset = CGSize.zero
        businessImageViewBorder.layer.shadowRadius = 4
        businessImageViewBorder.layer.shadowPath = UIBezierPath(roundedRect: businessImageViewBorder.bounds, cornerRadius: 10).cgPath
        
        bannerImageView.contentMode = .scaleAspectFill
        
        logoImageView.layer.cornerRadius = 12.0
        logoImageView.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //TODO: remove image requests from within view
        if let bannerURL = URL(string: banner) {
            NetworkController.shared.requestImage(bannerURL) { [weak self] image in
                self?.bannerActivityIndicator.stopAnimating()
                self?.bannerImageView.image = image
            }
        }
    
        if let logoURL = URL(string: logo) {
            NetworkController.shared.requestImage(logoURL) { [weak self] image in
                self?.logoImageView.image = image
            }
        }
    }
}
