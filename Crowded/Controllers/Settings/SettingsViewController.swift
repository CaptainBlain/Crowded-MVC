//
//  SettingsViewController.swift
//  Crowded
//
//  Created by Blain Ellis on 20/11/2020.
//

import UIKit

enum SettingsType: String {
    case suggestions = "Suggestions"
    case help = "Help"
    case contactSupport = "Contact Support"
    case about = "About"
    case taCs = "T&Cs"
    case privacyPolicy = "Privacy policy"
}

class SettingsViewController: BaseViewController {
    
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
        self.navigationController?.navigationBar.isTranslucent = false
        
        tableView.backgroundColor = UIColor(named: "tableBackground")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController?.navigationBar.isTranslucent = false
        setupNavBar()
        self.tableView.reloadData()
    }
    
    func setupNavBar() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: self.navigationController!.navigationBar.frame.size.height + 10))
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingsType = dataSource[indexPath.section][indexPath.row]
        switch settingsType {
        case .suggestions:
            openReportController(forType: .suggestion)
            tableView.deselectRow(at: indexPath, animated: true)
        case .help:
            self.performSegue(withIdentifier: "openWebViewController", sender: nil)
        case .contactSupport:
            openReportController(forType: .support)
            tableView.deselectRow(at: indexPath, animated: true)
        case .about:
            self.performSegue(withIdentifier: "openWebViewController", sender: nil)
        case .privacyPolicy:
            self.performSegue(withIdentifier: "openWebViewController", sender: nil)
        case .taCs:
            self.performSegue(withIdentifier: "openWebViewController", sender: nil)
        }
    }
    
    func openReportController(forType reportType: ReportType) {
        let vc = ReportViewController()
        vc.type = reportType
        let navCon = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navCon, animated: true, completion: nil)
    }
}

extension SettingsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openWebViewController" {
            if let vc = segue.destination as? WebViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let settingsType = dataSource[indexPath.section][indexPath.row]
                    print("settingsType: \(settingsType)")
                    switch settingsType {
                    case .suggestions:
                        print("")
                    case .help:
                        vc.urlString = "https://sites.google.com/view/crowded-help/home?authuser=1"
                    case .contactSupport:
                        print("")
                    case .about:
                        vc.urlString = "https://sites.google.com/view/crowded-about/home?authuser=1"
                    case .privacyPolicy:
                        vc.urlString = "https://sites.google.com/view/crowdedprivacypolicy/home?authuser=1"
                    case .taCs:
                        vc.urlString = "https://sites.google.com/view/crowded-terms-conditions/home?authuser=1"
                    }
                    self.tableView.deselectRow(at: indexPath, animated: true)
                }
            }
        }
    }
}
