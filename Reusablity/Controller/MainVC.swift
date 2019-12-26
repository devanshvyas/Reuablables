//
//  ViewController.swift
//  Reusablity
//
//  Created by Devansh Vyas on 16/05/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit

class MainVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLoggedIn()
    }
}

extension MainVC {
    func checkLoggedIn() {
        if let isLoggedIn = Defaults.shared.getData(key: .isLoggedIn) as? Bool, isLoggedIn {
            navigateToTimeline(nav: navigationController)
        }
    }
}
