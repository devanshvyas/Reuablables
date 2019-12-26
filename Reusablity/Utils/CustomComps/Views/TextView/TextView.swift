//
//  TextView.swift
//  ONUS
//
//  Created by Devansh Vyas on 22/01/19.
//  Copyright © 2019 Solution Analysts. All rights reserved.
//

import UIKit

@objc protocol TextViewDelegate {
    @objc optional func openDatePicker()
    @objc optional func textFieldChar(count: Int)
}

@IBDesignable class TextView: UIView {
    
    //MARK:- Outlets and Variables
    @IBOutlet var title: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var titleWidthConstraint: NSLayoutConstraint!
    
    weak var delegate: TextViewDelegate?
    
    //MARK:- View Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    func sharedInit() {
        nibSetup(nibName: .TextView)
        addLineToView(position: .bottom, color: Colors.bottomLine, width: 1)
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(onViewTapped))
        addGestureRecognizer(viewTap)
    }
    
    func setTitleAndLine(color: UIColor) {
        title.textColor = color
    }
    
    func titleWidth(size: CGFloat) {
        titleWidthConstraint.constant = size
    }
    
    @IBAction func editingChange(_ sender: UITextField) {
        if let text = textField.text {
            delegate?.textFieldChar?(count: text.count)
        }
    }
    
    @objc func onViewTapped() {
        if isTextField {
            textField.becomeFirstResponder()
        } else {
            textField.isEnabled = false
            delegate?.openDatePicker?()
        }
    }
    
    @IBInspectable var titleText: String = "" {
        didSet {
            title.text = titleText
        }
    }
    
    @IBInspectable var keyboardType: Int = 0 {
        didSet {
            textField.keyboardType = UIKeyboardType(rawValue: keyboardType) ?? UIKeyboardType.default
        }
    }
    
    @IBInspectable var isTextField: Bool = true {
        didSet {
            onViewTapped()
        }
    }
    
    @IBInspectable var securedText: Bool = false {
        didSet {
            textField.isSecureTextEntry = securedText
        }
    }
    
}



/* keyboardTypes:-
 0 `default` // Default type for the current input method.
 
 1 asciiCapable // Displays a keyboard which can enter ASCII characters
 
 2 numbersAndPunctuation // Numbers and assorted punctuation.
 
 3 URL // A type optimized for URL entry (shows . / .com prominently).
 
 4 numberPad // A number pad with locale-appropriate digits (0-9, ۰-۹, ०-९, etc.). Suitable for PIN entry.
 
 5 phonePad // A phone pad (1-9, *, 0, #, with letters under the numbers).
 
 6 namePhonePad // A type optimized for entering a person's name or phone number.
 
 7 emailAddress // A type optimized for multiple email address entry (shows space @ . prominently).
 
 @available(iOS 4.1, *)
 8 decimalPad // A number pad with a decimal point.
 
 @available(iOS 5.0, *)
 9 twitter // A type optimized for twitter text entry (easy access to @ #)
 
 @available(iOS 7.0, *)
 10 webSearch // A default keyboard type with URL-oriented addition (shows space . prominently).
 
 @available(iOS 10.0, *)
 11 asciiCapableNumberPad // A number pad (0-9) that will always be ASCII digits.
 */
