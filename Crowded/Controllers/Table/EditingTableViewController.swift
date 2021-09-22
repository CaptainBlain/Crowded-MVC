//
//  EditingTableViewController.swift
//  Crowded
//
//  Created by Blain Ellis on 20/11/2020.
//

import UIKit

class EditingTableViewController: TableViewController {
        
    var didUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    func setupNavBar() {
        
        self.navigationItem.hidesBackButton = true
        let backButton = getCustomBackButton(selector: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func back() {
         self.navigationController?.popViewController(animated: true)
    }
    

}
