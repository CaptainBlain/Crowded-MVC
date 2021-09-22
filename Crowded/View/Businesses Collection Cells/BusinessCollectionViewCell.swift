//
//  BusinessCollectionViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class BusinessCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BusinessCollectionViewCellId"
    
    @IBOutlet weak var imageViewBorder: UIView!
    @IBOutlet weak var imageViewBorderHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tagLabelBottomConstraint: NSLayoutConstraint!
    
    var business: Business? {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.text = nil
        tagLabel.text = nil
        
        if let business = business {
            
            imageViewBorder.backgroundColor = business.settings.backgroundColour.hexStringToUIColor
            imageViewBorder.layer.cornerRadius = 12.0
            
            imageView.backgroundColor = business.settings.backgroundColour.hexStringToUIColor
            imageView.layer.cornerRadius = 12.0
            imageView.contentMode = .scaleAspectFit

            if let url = URL(string: business.images.logo) {
                NetworkController.shared.requestImage(url) { [weak self] image in
                    self?.imageView.image = image
                }
            }

            let businessName = business.businessName.capitalized
            let titleSize = businessName.getStringSize(for: UIFont.helvetica(size: 19.0), andWidth: self.frame.size.width)
            titleLabelHeightConstraint.constant = titleSize.height
            titleLabel.text = businessName
            let tag = business.tagString.lowercased()
            let tagSize = tag.getStringSize(for: UIFont.helvetica(size: 13.0), andWidth: self.frame.size.width)
            
            tagLabelHeightConstraint.constant = tagSize.height
            tagLabel.text = tag

            let constraints = titleLabelHeightConstraint.constant + tagLabelHeightConstraint.constant + tagLabelBottomConstraint.constant
            
            imageViewBorderHeightConstraint.constant = self.frame.size.height - constraints - 8
            imageViewHeightConstraint.constant = imageViewBorderHeightConstraint.constant - 12
            // imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
}
