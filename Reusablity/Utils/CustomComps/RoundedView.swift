//
//  RoundedView.swift
//  SNDRND
//
//  Created by Zaid Pathan on 03/01/19.
//  Copyright © 2019 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundedView: UIView {
    
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
        updateBorderWidth(borderWidth)
        updateBorderColor(borderColor)
        updateCornerRadius(cornerRadius)
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
    
    //MARK:- Inspectable properties
    
    @IBInspectable var cornerRadius : CGFloat = 22.5 {
        didSet {
            updateCornerRadius(cornerRadius)
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0.5 {
        didSet {
            updateBorderWidth(borderWidth)
        }
    }
    
    @IBInspectable var borderColor : UIColor = .white {
        didSet {
            updateBorderColor(borderColor)
        }
    }
}
