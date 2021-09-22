//
//  ReportViewController.swift
//  Crowded
//
//  Created by Blain Ellis on 20/11/2020.
//

import UIKit
import JGProgressHUD

class ReportViewController: EditingTableViewController {
    
    var type: ReportType = .suggestion
    
    var keyboardHeight: CGFloat = 0.0
    
    var reportTitle = ""
    var reportDetails = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadTableData()
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func setupNavBar() {
        
        self.navigationItem.hidesBackButton = true
        let backButton = getCustomBackButton(selector: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
        
        let saveButton = getCustomNavButton(title: "Send", selector: #selector(sendReport))
        self.navigationItem.rightBarButtonItems =  [saveButton]
    }
    
    @objc func sendReport() {
                
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Sending \(self.type.rawValue.lowercased())"
        hud.show(in: self.navigationController?.view ?? self.view)
//        AsyncReport.createReport(title: reportTitle, details: reportDetails, type: type) { (error) in
//               hud.dismiss()
//            if let error = error {
//                self.showError("We were unable to send this \(self.type.rawValue.lowercased()) \n\(error.errorMessage)", okButtonPressed: nil)
//                return
//            }
//
//            self.postSuccessToast(" \(self.type.rawValue.lowercased()) sent successfully")
//            self.navigationController?.popViewController(animated: true)
//        }
    }
    
    override func back() {
        if didUpdate {
            showYesNoAlert(message: "Would you like to cancel sending this \(type.rawValue.lowercased())", confirmAction: {
                self.navigationController?.popViewController(animated: true)
            }, denyAction: {
                
            })
        }
        else {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func reloadTableData() {
        
        let space = TableViewLayout(cellType: .Space, value: "20")
        let title = TableViewLayout(cellType: .Header, value: type.rawValue)
        
        var details = ""
        switch type {
            case .suggestion:
                let bundleInfoDict: NSDictionary = Bundle.main.infoDictionary! as NSDictionary
                let appName = bundleInfoDict["CFBundleName"] as! String
                details = "Send us a \(type.rawValue.lowercased()) to help improve \(appName)"
            case .support:
                details = "How can we help?"
            case .report:
                details = "Tell us why you are reporting this notice"
        }
        
        let detail = TableViewLayout(cellType: .Details, value: details)
        let space2 = TableViewLayout(cellType: .Space, value: "10")
        let nameText = TableViewLayout(cellType: .TextField, value: reportTitle, placeholder: "Title")
        let descText = TableViewLayout(cellType: .TextView, value: reportDetails, placeholder: "Description")
        
        self.dataSource = [space, title, detail, space2, nameText, descText]
        
        self.tableView.reloadData()
    }
    
    override func textFieldTableViewCellDidUpdateText(text: String, tableViewLayout: TableViewLayout) {
        didUpdate = true
        reportTitle = text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    override func textViewTableViewCellDidUpdateText(text: String, tableViewLayout: TableViewLayout) {
        didUpdate = true
        reportDetails = text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var headerHeight: CGFloat = 0
    var detailHeight: CGFloat = 0
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableRow = dataSource[indexPath.row]
        if tableRow.cellType == .TextField {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as! TextFieldTableViewCell
            cell.tableLayoutDelegate = self
            cell.indexPath = indexPath
            cell.tableViewLayout = tableRow
            cell.textFieldPlaceholder = tableRow.placeholder
            cell.textFieldText = tableRow.value
            cell.cellTextField.keyboardType = .default
            cell.cellTextField.autocapitalizationType = .words
            if reportTitle.isEmpty {
                cell.cellTextField.becomeFirstResponder()
            }
            return cell
        }
        if tableRow.cellType == .TextView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextViewTableViewCell.identifier, for: indexPath) as! TextViewTableViewCell
            cell.tableLayoutDelegate = self
            cell.indexPath = indexPath
            cell.tableViewLayout = tableRow
            cell.textFieldPlaceholder = tableRow.placeholder
            cell.textViewText = tableRow.value
            if reportTitle.isNotEmpty {
                cell.cellTextView.becomeFirstResponder()
            }
            return cell
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableRow = dataSource[indexPath.row]
        
        if tableRow.cellType == .Header {
            let value = tableRow.value.isNotEmpty ? tableRow.value : tableRow.placeholder
            if let size = value?.getStringSize(for: UIFont.KailasaRegular(26.0), andWidth: tableView.frame.size.width - 40) {
                headerHeight = size.height + 10
            }
        }
        
        if tableRow.cellType == .Details {
            let value = tableRow.value.isNotEmpty ? tableRow.value : tableRow.placeholder
            if let size = value?.getStringSize(for: UIFont.KailasaRegular(17.0), andWidth: tableView.frame.size.width - 40) {
                detailHeight = size.height + 10
            }
        }
                
        if tableRow.cellType == .TextView {
            return tableView.frame.size.height - (20 + headerHeight + detailHeight + 10 + 65 + keyboardHeight)
        }


        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
}

extension ReportViewController {
    
    // MARK: - KeyboardWill Delegate
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        keyboardHeight = 0
    }
    
}
