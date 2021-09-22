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
    var businessDetails: BusinessDetails!
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate enum BusinessSections: Int, TableViewEnum {
        case header = 0
        case address
        case contact
    }
    
    fileprivate enum HeaderSections: Int, TableViewEnum {
        case image = 0
        case title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .clear
        tableView.sectionHeaderHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch BusinessSections.build(with: indexPath.section) {
        case .header:
            switch HeaderSections.build(with: indexPath.item) {
            case .image:
                let cell = tableView.dequeueReusableCell(withIdentifier: BusinessImageHeaderTableViewCell.identifier, for: indexPath) as! BusinessImageHeaderTableViewCell
                cell.business = businessDetails
                return cell
            case .title:
                let cell = tableView.dequeueReusableCell(withIdentifier: BusinessHeaderTableViewCell.identifier, for: indexPath) as! BusinessHeaderTableViewCell
                cell.business = businessDetails
                return cell
            }
        case .address:
            let cell = tableView.dequeueReusableCell(withIdentifier: BusinessLocationTableViewCell.identifier, for: indexPath) as! BusinessLocationTableViewCell
            cell.business = businessDetails
            return cell
        case .contact:
            let cell = tableView.dequeueReusableCell(withIdentifier: BusinessContactTableViewCell.identifier, for: indexPath) as! BusinessContactTableViewCell
            cell.business = businessDetails
            return cell
        }
    }
}

extension BusinessDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch BusinessSections.build(with: indexPath.section) {
        case .header:
            print("")
        case .address:
            print("")
        case .contact:
            openContactActionSheet()
        }
        
    }
    
    func openContactActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if self.traitCollection.userInterfaceStyle == .dark {
            alertController.view.tintColor = UIColor.whiteColor();
        }
        if !businessDetails.contact.website.isEmpty {
            alertController.addAction(UIAlertAction(title: "Visit Website", style: .default) {  _ in
                self.performSegue(withIdentifier: "openBusinessWebsite", sender: nil)
            })
        }
        if !businessDetails.contact.phone.isEmpty {
            alertController.addAction(UIAlertAction(title: "Make Call", style: .default) {  _ in
                self.checkAllowedPhoneNumber(business: self.businessDetails)
            })
        }
        if !businessDetails.contact.email.isEmpty {
            alertController.addAction(UIAlertAction(title: "Send Email", style: .default) {  _ in
                self.sendEmail()
            })
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    // Phone Call
    func checkAllowedPhoneNumber(business: BusinessDetails) {
        if let telephoneNumber = business.contact.phone.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            phonecall(telephoneNumber: telephoneNumber, name: business.businessName)
        }
        else {
            displayUnableToCallAlert(name: business.businessName)
        }
    }
    
    func phonecall(telephoneNumber:String, name: String) {
        
        let string = "tel://\(telephoneNumber)"
        if let telephoneURL = URL(string: string) {
            if UIApplication.shared.canOpenURL(telephoneURL) {
                
                let alert = UIAlertController(title: "Do you want to call \(name)", message: nil, preferredStyle: .alert)
                let logoutButton = UIAlertAction(title: "Call", style: UIAlertAction.Style.default) { (_) -> Void in
                    
                    let url = URL(string: "tel://\(telephoneNumber)")!
                    UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                        print("Open url : \(success)")
                    })
                }
                
                let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(logoutButton)
                alert.addAction(cancelButton)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                let alert = UIAlertController(title: "Unable to call \(name)", message: "Sorry, it seems your \(UIDevice.current.model) doesn't support telephone calls.", preferredStyle: .alert)
                let cancelButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(cancelButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func displayUnableToCallAlert(name: String) {
        let alert = UIAlertController(title: "Unable to call \(name)", message: "No number found", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Email
    
}

extension BusinessDetailViewController: MFMailComposeViewControllerDelegate {
    
    func sendEmail() {
        // Modify following variables with your text / recipient
        let recipientEmail = "\(businessDetails.contact.email)"
        let subject = "Enquiry from Crowded iOS App"
        let body = ""
        
        // Show default mail composer
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipientEmail])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            
            present(mail, animated: true)
            
            // Show third party email composer if default Mail app is not present
        } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
            UIApplication.shared.open(emailUrl)
        }
    }
    
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

//BusinessViewController
extension BusinessDetailViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openBusinessWebsite" {
            if let vc = segue.destination as? WebViewController {
                vc.urlString = "\(businessDetails.contact.website)"
            }
        }
    }
}
