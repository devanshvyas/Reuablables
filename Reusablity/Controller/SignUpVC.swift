//
//  SignUpVC.swift
//  Reusablity
//
//  Created by Devansh Vyas on 16/05/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit

class SignUpVC: BaseViewController {

    @IBOutlet weak var email: TextView!
    @IBOutlet weak var password: TextView!
    @IBOutlet weak var name: TextView!
    @IBOutlet weak var dob: TextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dob.delegate = self
        email.textField.text = "test@sa.com"
        password.textField.text = "Test@123"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    @IBAction func signUpPressed(_ sender: RoundedButton) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            Defaults.shared.setData(key: .isLoggedIn, data: true)
            let nav = self.presentingViewController as? UINavigationController
            self.dismiss(animated: true, completion: {
                self.navigateToHome(nav: nav)
            })
        }
    }
    
    @IBAction func cancelPressed(_ sender: RoundedButton) {
        dismiss(animated: true)
    }
}

extension SignUpVC: TextViewDelegate {
    func openDatePicker() {
//        self.view.endEditing(true)
        UIDatePickerController.pickDate(viewController: self, title: "DOB", pickTitle: "Select", cancelTitle: "Cancel", delegate: self, isMaxToday: true)
    }
}

extension SignUpVC: UIDatePickerControllerDelegate {
    func didPickDate(data: Date?, mode: UIDatePicker.Mode) {
        guard let date = data else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yy"
        dob.textField.text = dateFormatter.string(from: date)
    }
}
