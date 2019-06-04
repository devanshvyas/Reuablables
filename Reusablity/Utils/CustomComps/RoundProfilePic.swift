//
//  RoundProfilePic.swift
//  SNDRND
//
//  Created by Devansh Vyas on 31/12/18.
//  Copyright © 2018 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit

@IBDesignable class RoundedProfilePic: UIImageView {
    
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
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2
        updateBorderColor(borderColor)
    }
    
    //MARK:- Private setter helper
    fileprivate func updateBorderColor(_ value: UIColor) {
        self.layer.borderWidth = 1
        self.layer.borderColor = value.cgColor
    }
    
    //MARK:- Inspectable properties
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            updateBorderColor(borderColor)
        }
    }
}
