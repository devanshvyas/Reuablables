//
//  PopUpView.swift
//  ONUS
//
//  Created by Devansh Vyas on 03/06/19.
//  Copyright © 2019 Solution Analysts. All rights reserved.
//

import UIKit

@IBDesignable class PopUpBgView: UIView {
    
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
        self.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
        self.layer.shadowOpacity = Float(0.75)
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).cgColor
        updateShadowWidth(shadowWidth)
        updateBorderColor(borderColor)
        updateCornerRadius(cornerRadius)
    }
    
    //MARK:- Private setter helper
    
    fileprivate func updateShadowWidth(_ value: CGFloat) {
        self.layer.shadowRadius = value
    }
    
    fileprivate func updateBorderColor(_ value: UIColor) {
        self.layer.borderColor = value.cgColor
    }
    
    fileprivate func updateCornerRadius(_ value: CGFloat) {
        self.layer.cornerRadius = value
    }
    
    
    //MARK:- Inspectable properties
    
    @IBInspectable var cornerRadius : CGFloat = CGFloat(7) {
        didSet {
            updateCornerRadius(cornerRadius)
        }
    }
    
    @IBInspectable var shadowWidth : CGFloat = CGFloat(3) {
        didSet {
            updateShadowWidth(shadowWidth)
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75) {
        didSet {
            updateBorderColor(borderColor)
        }
    }
    
}
