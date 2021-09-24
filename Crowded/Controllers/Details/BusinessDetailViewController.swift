//
//  BusinessViewController.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import MessageUI
import UIKit

class BusinessDetailViewController: UIViewController {
    
    var business: Business!
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate enum HeaderSections: Int, TableViewEnum {
        case image = 0
        case title
    }
    
    fileprivate enum BusinessSections: Int, TableViewEnum {
        case header = 0
        case location
        case times
        case website
        case contact
    }
    
}

extension BusinessDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return BusinessSections.all.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch BusinessSections.build(with: section) {
        case .header:
            return HeaderSections.all.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch BusinessSections.build(with: indexPath.section) {
        case .header:
            switch HeaderSections.build(with: indexPath.item) {
            case .image:
                let cell = tableView.dequeueReusableCell(withIdentifier: BusinessImageHeaderTableViewCell.identifier, for: indexPath) as! BusinessImageHeaderTableViewCell
                cell.businessImageViewBorder.backgroundColor = business.settings.getBackgroundColour()
                cell.bannerImageView.backgroundColor = business.settings.getBackgroundColour()
                cell.logoImageView.backgroundColor = business.settings.getBackgroundColour()

                cell.banner = business.images.banner
                cell.logo = business.images.logo

                return cell
            case .title:
                let cell = tableView.dequeueReusableCell(withIdentifier: BusinessHeaderTableViewCell.identifier, for: indexPath) as! BusinessHeaderTableViewCell
                cell.titleLabel.text = business.businessName.capitalized
                cell.tagLabel.text = business.tagString
                cell.descTextView.text = business.businessDesc
                return cell
            }
        case .location:
            let cell = tableView.dequeueReusableCell(withIdentifier: BusinessLocationTableViewCell.identifier, for: indexPath) as! BusinessLocationTableViewCell
            cell.cityLabel.text = business.businessAddress.city.capitalized
            cell.addressLabel.text = business.businessAddress.addressString
            return cell
        case .times:
            let cell = tableView.dequeueReusableCell(withIdentifier: BusinessTimesTableViewCell.identifier, for: indexPath) as! BusinessTimesTableViewCell
            cell.openingTimesDetailsLabel.text = business.openingTimes.openingTimesString
            return cell
        case .website:
            let cell = tableView.dequeueReusableCell(withIdentifier: BusinessWebsiteTableViewCell.identifier, for: indexPath) as! BusinessWebsiteTableViewCell
            cell.websiteDetailsLabel.text = business.contact.website
            return cell
        case .contact:
            let cell = tableView.dequeueReusableCell(withIdentifier: BusinessContactTableViewCell.identifier, for: indexPath) as! BusinessContactTableViewCell
            cell.phoneNumberLabel.text = business.contact.phone
            cell.emailLabel.text = business.contact.email
            return cell
        }
    }
}


