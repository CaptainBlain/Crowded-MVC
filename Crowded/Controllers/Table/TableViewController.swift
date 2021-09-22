//
//  TableViewController.swift
//  Crowded
//
//  Created by Blain Ellis on 20/11/2020.
//

import Foundation

import UIKit

class TableViewController: UITableViewController, TextFieldTableViewCellTableLayoutDelegate, TextViewTableViewCellTableViewLayoutDelegate {
    
    var dataSource = [TableViewLayout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clear
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: HeaderTableViewCell.identifier)
        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: DetailsTableViewCell.identifier)
        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        tableView.register(UINib(nibName: "TextViewTableViewCell", bundle: nil), forCellReuseIdentifier: TextViewTableViewCell.identifier)
        
        tableView.register(UINib(nibName: "SpaceTableViewCell", bundle: nil), forCellReuseIdentifier: SpaceTableViewCell.identifier)
        tableView.register(UINib(nibName: "SpacerTableViewCell", bundle: nil), forCellReuseIdentifier: SpacerTableViewCell.identifier)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: TextFieldTableViewCellTableLayoutDelegate
    
    
    func textFieldTableViewCellBeginEditing(forTableViewLayout tableViewLayout: TableViewLayout) {
        
        
    }
    
    func textFieldTableViewCellDidUpdateText(text: String, tableViewLayout: TableViewLayout) {
        
        
    }
    
    func textFieldTableViewCellEndEditing(forTableViewLayout tableViewLayout: TableViewLayout) {
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let tableRow = dataSource[indexPath.row]
        
        switch tableRow.cellType {
            
            
        case .Header:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier, for: indexPath) as! HeaderTableViewCell
            cell.cellLabelTitle = tableRow.value
            return cell
        case .Details:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as! DetailsTableViewCell
            cell.cellLabelPlaceholder = tableRow.placeholder
            cell.cellLabelTitle = tableRow.value
            return cell
        case .TextField:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as! TextFieldTableViewCell
            cell.tableLayoutDelegate = self
            cell.indexPath = indexPath
            cell.tableViewLayout = tableRow
            cell.textFieldPlaceholder = tableRow.placeholder
            cell.textFieldText = tableRow.value
            cell.cellTextField.keyboardType = .default
            cell.cellTextField.autocapitalizationType = .words
            return cell
        case .TextView:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextViewTableViewCell.identifier, for: indexPath) as! TextViewTableViewCell
            cell.tableLayoutDelegate = self
            cell.indexPath = indexPath
            cell.tableViewLayout = tableRow
            cell.textFieldPlaceholder = tableRow.placeholder
            cell.textViewText = tableRow.value
            return cell
        case .Space:
            return tableView.dequeueReusableCell(withIdentifier: SpaceTableViewCell.identifier, for: indexPath) as! SpaceTableViewCell
        case .Spacer:
            return tableView.dequeueReusableCell(withIdentifier: SpacerTableViewCell.identifier, for: indexPath) as! SpacerTableViewCell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableRow = dataSource[indexPath.row]
        
        var height: CGFloat = 0.0
        switch tableRow.cellType {
        case .Header:
            let value = tableRow.value.isNotEmpty ? tableRow.value : tableRow.placeholder
            if let size = value?.getStringSize(for: UIFont.KailasaRegular(26.0), andWidth: tableView.frame.size.width - 40) {
                height = size.height + 10
            }
        case .Details:
            let value = tableRow.value.isNotEmpty ? tableRow.value : tableRow.placeholder
            if let size = value?.getStringSize(for: UIFont.KailasaRegular(17.0), andWidth: tableView.frame.size.width - 40) {
                height = size.height + 10
            }
        case .TextField:
            height = 65
        case .TextView:
            height = 108
        case .Space:
            if let value = (tableRow.value as NSString?) {
                height = CGFloat(value.floatValue)
            }
        case .Spacer:
            if let value = (tableRow.value as NSString?) {
                height = CGFloat(value.floatValue)
            }
        case .none:
            height = 0
        }
        return height
    }
    
    
    //MARK: TextViewTableViewCellTableViewLayoutDelegate
    func textViewTableViewCellBeginEditing(forTableViewLayout tableViewLayout: TableViewLayout) {
        
    }
    func textViewTableViewCellDidUpdateText(text: String, tableViewLayout: TableViewLayout) {
        
        
    }
    
}
