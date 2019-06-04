//
//  ViewController.swift
//  Reusablity
//
//  Created by Devansh Vyas on 16/05/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        checkLoggedIn()
    }

}

extension MainViewController {
    func checkLoggedIn() {
        if let isLoggedIn = Defaults.shared.getData(key: .isLoggedIn) as? Bool, isLoggedIn {
            navigateToHome(nav: navigationController)
        }
    }
}
