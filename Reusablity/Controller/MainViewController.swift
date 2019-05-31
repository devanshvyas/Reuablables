//
//  ViewController.swift
//  Reusablity
//
//  Created by Devansh Vyas on 16/05/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign In"
    }

    @IBAction func signInPressed(_ sender: RoundedButton) {
        Defaults.shared.setData(key: .isLoggedIn, data: true)
    }
    
}

extension MainViewController {
    func checkLoggedIn() {
        if let isLoggedIn = Defaults.shared.getData(key: .isLoggedIn) as? Bool, isLoggedIn {
            
        }
    }
}
