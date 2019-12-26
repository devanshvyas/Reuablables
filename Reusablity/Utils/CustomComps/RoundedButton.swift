//
//  RoundedButton.swift
//  ONUS
//
//  Created by Devansh Vyas on 17/01/19.
//  Copyright © 2019 Solution Analysts. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
    
    //MARK:- Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    func sharedInit() {
        self.imageView?.contentMode = .scaleAspectFill
        updateBorderWidth(borderWidth)
        updateBorderColor(borderColor)
        updateCornerRadius(cornerRadius)
        updateFontColor(fontColor)
    }
    
    //MARK:- Private setter helper
    fileprivate func updateBorderWidth(_ value: CGFloat) {
        self.layer.borderWidth = value
    }
    
    fileprivate func updateBorderColor(_ value: UIColor) {
        self.layer.borderColor = value.cgColor
    }
    
    fileprivate func updateCornerRadius(_ value: CGFloat) {
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.layer.cornerRadius = value
    }
    
    fileprivate func updateFontColor(_ value: UIColor) {
        self.setTitleColor(value, for: .normal)
    }
    
    
    //MARK:- Inspectable properties
    @IBInspectable var cornerRadius: CGFloat = 25 {
        didSet {
            updateCornerRadius(cornerRadius)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            updateBorderWidth(borderWidth)
        }
    }
    
    @IBInspectable var borderColor: UIColor = .white {
        didSet {
            updateBorderColor(borderColor)
        }
    }
    
    @IBInspectable var fontColor: UIColor = .white {
        didSet {
            updateFontColor(fontColor)
        }
    }
    
}
