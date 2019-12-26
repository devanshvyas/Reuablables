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
//        backgroundColor = Colors.popUpBg
        layer.shadowOpacity = Float(0.75)
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowColor = Colors.popUpShadow
        updateShadowWidth(shadowWidth)
        updateBorderColor(borderColor)
        updateCornerRadius(cornerRadius)
    }
    
    //MARK:- Private setter helper
    
    fileprivate func updateShadowWidth(_ value: CGFloat) {
        layer.shadowRadius = value
    }
    
    fileprivate func updateBorderColor(_ value: UIColor) {
        layer.borderColor = value.cgColor
    }
    
    fileprivate func updateCornerRadius(_ value: CGFloat) {
        layer.cornerRadius = value
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
    
    @IBInspectable var borderColor : UIColor = Colors.popUpBgBorder {
        didSet {
            updateBorderColor(borderColor)
        }
    }
    
}
