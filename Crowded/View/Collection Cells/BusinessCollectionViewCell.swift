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
    
    var logo: String = "" {
        didSet {
            layoutSubviews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewBorder.layer.cornerRadius = 12.0
        imageView.layer.cornerRadius = 12.0
        imageView.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.text = nil
        tagLabel.text = nil
        
        if let url = URL(string: logo) {
            NetworkController.shared.requestImage(url) { [weak self] image in
                self?.imageView.image = image
            }
        }
        
        if let titleSize = titleLabel.text?.getStringSize(for: UIFont.helvetica(size: 19.0), andWidth: frame.size.width) {
            titleLabelHeightConstraint.constant = titleSize.height
        }
        
        if let tagSize = tagLabel.text?.getStringSize(for: UIFont.helvetica(size: 13.0), andWidth: frame.size.width) {
            tagLabelHeightConstraint.constant = tagSize.height
        }
        
        let constraints = titleLabelHeightConstraint.constant + tagLabelHeightConstraint.constant + tagLabelBottomConstraint.constant
        
        imageViewBorderHeightConstraint.constant = frame.size.height - constraints - 8
        imageViewHeightConstraint.constant = imageViewBorderHeightConstraint.constant - 12
        
        
    }
}
