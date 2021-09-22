//
//  WebViewController.swift
//  Crowded
//
//  Created by Blain Ellis on 20/11/2020.
//

import UIKit
import WebKit
import JGProgressHUD

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlString = "https://sites.google.com/view/memoriam-privacy-policy/home?authuser=1"
    
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.webView.backgroundColor = UIColor(named: "backgroundColor")
        self.webView.navigationDelegate = self
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        
        if let url = URL(string: urlString) {
        let request = URLRequest(url: url)
               hud.textLabel.text = "Loading..."
               hud.show(in: self.view)
              self.webView.load(request)
        }
      
    }
    
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        hud.dismiss()
        if !UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hud.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hud.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.title = ""
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("\(String(describing: navigationAction.request.url?.absoluteString))")
        
        decisionHandler(.allow)
    }
}
