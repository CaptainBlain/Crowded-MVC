//
//  SettingsTableViewCell.swift
//  Crowded
//
//  Created by Blain Ellis on 20/11/2020.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    static let identifier = "SettingsTableViewCellIdentifier"
    
    var titleString = ""
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var rightArrowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rightArrowImageView.isHidden = false
        selectionStyle = .default
        cellTitleLabel.font = UIFont.KailasaBold(19.0)
        cellTitleLabel.textColor = UIColor.getDarkGreyColor(1.0)
        cellTitleLabel.text = titleString
    }
    
}
