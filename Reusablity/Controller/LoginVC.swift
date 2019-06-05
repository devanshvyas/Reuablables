//
//  LoginVC.swift
//  Reusablity
//
//  Created by Devansh Vyas on 16/05/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {

    @IBOutlet weak var email: TextView!
    @IBOutlet weak var password: TextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.textField.text = "test@sa.com"
        password.textField.text = "Test@123"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func signInPressed(_ sender: RoundedButton) {
        isLoading = true
        if let email = email.textField.text, email == "test@sa.com", let pw = password.textField.text, pw == "Test@123" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.isLoading = false
                Defaults.shared.setData(key: .isLoggedIn, data: true)
                let nav = self.presentingViewController as? UINavigationController
                self.dismiss(animated: true, completion: {
                    self.navigateToHome(nav: nav)
                })
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.isLoading = false
                self.alert(msg: "Please check the credentials!!")
            }
        }
    }
    
    @IBAction func cancelPressed(_ sender: RoundedButton) {
        dismiss(animated: true)
    }
}
