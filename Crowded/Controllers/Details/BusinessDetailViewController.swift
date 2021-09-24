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
        case address
        case contact
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .clear
        //tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
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
        case .address:
            return 1
        case .contact:
            return 1
        }
    }

    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        var height: CGFloat = 60.0;
    //        switch BusinessSections.build(with: indexPath.section) {
    //        case .header:
    //            switch HeaderSections.build(with: indexPath.item) {
    //            case .image:
    //                height = 60
    //            case .title:
    //                height = 60
    //            }
    //        case .address:
    //            height = 60
    //        case .contact:
    //            height = 60
    //        }
    //        return height
    //    }
        
    
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
        case .address:
            let cell = tableView.dequeueReusableCell(withIdentifier: BusinessLocationTableViewCell.identifier, for: indexPath) as! BusinessLocationTableViewCell
            cell.business = business
            return cell
        case .contact:
            let cell = tableView.dequeueReusableCell(withIdentifier: BusinessContactTableViewCell.identifier, for: indexPath) as! BusinessContactTableViewCell
            cell.business = business
            return cell
        }
    }
}


