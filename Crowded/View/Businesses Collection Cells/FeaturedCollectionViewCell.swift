//
//  FeaturedCollectionViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeaturedCollectionViewCellId"
    
    @IBOutlet weak var imageViewBorder: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cover: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagLabelHeightConstraint: NSLayoutConstraint!
    
    var business: Business? {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.text = nil
        tagLabel.text = nil
        
        cover.alpha = 0.2
        cover.layer.cornerRadius = 12.0
        
        if let business = business {
            
            imageViewBorder.backgroundColor = business.settings.backgroundColour.hexStringToUIColor
            imageViewBorder.layer.cornerRadius = 12.0
            
            imageView.backgroundColor = business.settings.backgroundColour.hexStringToUIColor
            imageView.contentMode = .scaleAspectFit

            if let url = URL(string: business.images.logo) {
                NetworkController.shared.requestImage(url) { [weak self] image in
                    self?.imageView.image = image
                }
            }

            let businessName = business.businessName
//            let titleSize = businessName.getStringSize(for: UIFont.helvetica(size: 17.0), andWidth: self.frame.size.width)
//            titleLabelHeightConstraint.constant = titleSize.height
            titleLabel.text = businessName
            tagLabel.text = business.tagString

            // imageViewHeightConstraint.constant = self.imageView.frame.size.width
            // imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
}
