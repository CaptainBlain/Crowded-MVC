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
    @IBOutlet weak var tagLabel: UILabel!
    
    var logo: String = "" {
        didSet {
            layoutSubviews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewBorder.layer.cornerRadius = 12.0
        imageView.contentMode = .scaleAspectFit
        
        cover.alpha = 0.2
        cover.layer.cornerRadius = 12.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.text = nil
        tagLabel.text = nil
        
        if let logo = URL(string: logo) {
            NetworkController.shared.requestImage(logo) { [weak self] image in
                self?.imageView.image = image
            }
        }

    }
}
