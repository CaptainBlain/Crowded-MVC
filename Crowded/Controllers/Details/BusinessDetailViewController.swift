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
                cell.business = business
                return cell
            case .title:
                let cell = tableView.dequeueReusableCell(withIdentifier: BusinessHeaderTableViewCell.identifier, for: indexPath) as! BusinessHeaderTableViewCell
                cell.business = business
                return cell
            }
        case .location:
            let cell = tableView.dequeueReusableCell(withIdentifier: BusinessLocationTableViewCell.identifier, for: indexPath) as! BusinessLocationTableViewCell
            cell.business = business
            return cell
        case .times:
            let cell = tableView.dequeueReusableCell(withIdentifier: BusinessTimesTableViewCell.identifier, for: indexPath) as! BusinessTimesTableViewCell
            cell.business = business
            return cell
        case .website:
            let cell = tableView.dequeueReusableCell(withIdentifier: BusinessWebsiteTableViewCell.identifier, for: indexPath) as! BusinessWebsiteTableViewCell
            cell.business = business
            return cell
        case .contact:
            let cell = tableView.dequeueReusableCell(withIdentifier: BusinessContactTableViewCell.identifier, for: indexPath) as! BusinessContactTableViewCell
            cell.business = business
            return cell
        }
    }
}


