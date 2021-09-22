//
//  BaseViewController.swift
//  Crowded
//
//  Created by Blain Ellis on 20/11/2020.
//

import UIKit

class BaseViewController: UIViewController {
        
    func statusBarColor() {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            // Reference - https://stackoverflow.com/a/57899013/7316675
            let statusBar = UIView(frame: window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = .white
            window?.addSubview(statusBar)
        }
    }
    
}
