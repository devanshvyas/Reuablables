//
//  UIView.swift
//  ONUS
//
//  Created by Devansh Vyas on 21/01/19.
//  Copyright © 2019 Solution Analysts. All rights reserved.
//

import UIKit

enum NibNames: String {
    case TimelineView
    case GameDisk
    case TextView
}

extension UIView {
    
    //MARK: To add line to view:-
    enum LINE_POSITION {
        case LINE_POSITION_TOP
        case LINE_POSITION_BOTTOM
    }
    
    func addLineToView(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
    
    
    //MARK: To add blur effect to your view
    func overlayBlurredBackgroundView(alpha: CGFloat = 0.95) {
        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.frame = frame
        blurredBackgroundView.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurredBackgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurredBackgroundView.alpha = alpha
        pinAndAddSubview(toView: blurredBackgroundView)
    }
    
    
    //MARK: To load nib
    func nibSetup(nibName: NibNames) {
        backgroundColor = .clear
        
        let view = Bundle(for: self.classForCoder).loadNibNamed(nibName.rawValue, owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        view.isUserInteractionEnabled = true
        
        addSubview(view)
    }
    
    func pinAndAddSubview(toView: UIView, constant: CGFloat = 0) {
        toView.translatesAutoresizingMaskIntoConstraints = false
        DispatchQueue.main.async {
            self.addSubview(toView)
            NSLayoutConstraint(item: toView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: constant).isActive = true
            
            NSLayoutConstraint(item: toView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: constant).isActive = true
            
            NSLayoutConstraint(item: toView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: constant).isActive = true
            
            NSLayoutConstraint(item: toView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: constant).isActive = true
        }
    }
    
    
    
}
