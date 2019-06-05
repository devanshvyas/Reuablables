//
//  BaseViewController.swift
//  Reusablity
//
//  Created by Devansh Vyas on 29/05/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    @IBOutlet weak var blurView: UIView?
    
    private var activityIndicator: UIActivityIndicatorView?
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                activityIndicator?.startAnimating()
            } else {
                activityIndicator?.stopAnimating()
            }
            view.isUserInteractionEnabled = !isLoading
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        blurView?.overlayBlurredBackgroundView()
        activityIndicator = getActivityMonitor(view: view)
        hideKeyboardGesture()
    }
    
    func navigateToHome(nav: UINavigationController?) {
        guard let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") else { return }
        print("not returned!")
        nav?.pushViewController(homeVC, animated: false)
    }
    
}
