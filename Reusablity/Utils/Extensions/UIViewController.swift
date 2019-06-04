//
//  UIViewController.swift
//  Reusablity
//
//  Created by Devansh Vyas on 31/05/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert(msg: String?, b1Text: String = "OK", b2Text: String = "", onB1Click: @escaping (()->()) = {}, onB2Click: @escaping (()->()) = {}) {
        
        let alert = UIAlertController(title: nil, message: msg ?? "Something went wrong.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: b1Text, style: UIAlertAction.Style.default, handler: { (action) in
            onB1Click()
        }))
        
        if !b2Text.isEmpty {
            alert.addAction(UIAlertAction(title: b2Text, style: UIAlertAction.Style.default, handler: { (action) in
                onB2Click()
            }))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getActivityMonitor(view: UIView) -> UIActivityIndicatorView {
        let activityMonitor = UIActivityIndicatorView(style: .whiteLarge)
        activityMonitor.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityMonitor.center = view.center
        activityMonitor.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        activityMonitor.center.y -= 64
        activityMonitor.layer.cornerRadius = 6.0
        DispatchQueue.main.async {
            view.addSubview(activityMonitor)
        }
        return activityMonitor
    }
}
