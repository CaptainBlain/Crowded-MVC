//
//  SettingsViewController.swift
//  Crowded
//
//  Created by Blain Ellis on 20/11/2020.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    private var themeColor = UIColor.white
    
    var dataSource: [[SettingsType]] {
        
        return [[SettingsType.suggestions], [SettingsType.help , SettingsType.contactSupport, SettingsType.about], [SettingsType.taCs, SettingsType.privacyPolicy]]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBarColor()
        navigationController?.navigationBar.isTranslucent = false
        
        tableView.backgroundColor = UIColor(named: "tableBackground")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        setupNavBar()
        tableView.reloadData()
    }
    
    func setupNavBar() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: navigationController!.navigationBar.frame.size.height + 10))
        titleView.backgroundColor = .clear
        let label = UILabel(frame: CGRect(x: 12, y: 12, width: titleView.frame.size.width, height: titleView.frame.size.height))
        label.text = "Settings"
        label.font = UIFont.KailasaBold(29.0)
        label.backgroundColor = .clear
        titleView.addSubview(label)
        navigationItem.titleView = titleView
        navigationItem.titleView?.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.height, height: 30))
        view.backgroundColor = UIColor(named: "backgroundColor")
        let label = UILabel(frame: CGRect(x: 12, y: 0, width: view.frame.size.width - 12, height: view.frame.size.height))
        label.font = UIFont.KailasaBold(14.0)
        label.textColor = UIColor(named: "generalTitleColor")
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height: CGFloat = 0
        switch section {
        case 0:
            height = 0
        default:
            height = 30
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingsType = dataSource[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
        cell.titleString = settingsType.rawValue
        return cell
    }
  
}
