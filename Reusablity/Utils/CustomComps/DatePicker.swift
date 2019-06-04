//
//  UIDatePickerController.swift
//  UIDatePickerController
//
//  Created by Devansh Vyas on 24/10/16.
//  Copyright © 2016 Devansh Vyas. All rights reserved.
//

import UIKit

struct PickerConstants{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let pickerWidth = 350
    static let pickerHeight = 300
}

@objc protocol UIDatePickerControllerDelegate {
    func didPickDate(data:Date?, mode: UIDatePicker.Mode)
    @objc optional func didCancelPickingDate()
}

class UIDatePickerController: UIViewController {
    weak var delegate:UIDatePickerControllerDelegate?
    var pickerTitle:String?
    var pickTitle:String?
    var cancelTitle:String?
    var backgroundView:UIView?
    var lblTitle:UILabel?
    var pickerContainerView:UIVisualEffectView?
    var rootVC:UIViewController?
    var datePicker:UIDatePicker?
    var titleLabel:UILabel?
    var pickButton:UIButton?
    var cancelButton:UIButton?
    var pickerMode: UIDatePicker.Mode?
    
    public class func pickDate(viewController: UIViewController,
                               title:String?,
                               pickTitle:String?,
                               cancelTitle:String?,
                               delegate:UIDatePickerControllerDelegate?,
                               mode: UIDatePicker.Mode = .date,
                               isMaxToday: Bool = false,
                               isMinToday: Bool = false) {
        let datePicker = UIDatePickerController(
            title: title,
            pickTitle: pickTitle,
            cancelTitle: cancelTitle,
            delegate:delegate,
            mode: mode,
            isMaxToday: isMaxToday,
            isMinToday: isMinToday)
        
        viewController.addChild(datePicker)
    }
    
    convenience init(title:String?,pickTitle:String?,cancelTitle:String?,delegate:UIDatePickerControllerDelegate?, mode: UIDatePicker.Mode = .date, isMaxToday: Bool, isMinToday: Bool) {
        self.init()
        rootVC = UIApplication.shared.keyWindow?.rootViewController
        self.pickerTitle = title
        self.pickTitle = pickTitle
        self.cancelTitle = cancelTitle
        self.delegate = delegate
        pickerMode = mode
        setupPickerView(mode, isMaxToday: isMaxToday, isMinToday: isMinToday)
        return
    }
    
    func shared(){
        
    }
    
    private func setupPickerView(_ mode: UIDatePicker.Mode, isMaxToday: Bool, isMinToday: Bool){
        self.view.backgroundColor = UIColor.clear
        addBlurrEffectView(mode, isMaxToday: isMaxToday, isMinToday: isMinToday)
    }
    
    private func addBlurrEffectView(_ mode: UIDatePicker.Mode, isMaxToday: Bool, isMinToday: Bool){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        pickerContainerView = UIVisualEffectView(effect: blurEffect)
        pickerContainerView?.layer.cornerRadius = 15
        pickerContainerView?.clipsToBounds = true
        pickerContainerView?.frame = CGRect(x: 0, y: 0, width: PickerConstants.pickerWidth, height: PickerConstants.pickerHeight)
        pickerContainerView?.center = self.view.center
        pickerContainerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addTitleLabel()
        self.addDatePicker(mode, isMaxToday: isMaxToday, isMinToday: isMinToday)
        self.addHorizontalSeperator()
        self.addVerticalSeperator()
        self.addButtons()
        pickerContainerView?.contentView.backgroundColor = Colors.pickDate
        view.addSubview(pickerContainerView!)
        
        
        rootVC?.addChild(self)
        rootVC?.view.addSubview(self.view)
        self.didMove(toParent: self)
    }
    
    private func addTitleLabel(){
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: PickerConstants.pickerWidth, height: 50))
        titleLabel?.font = UIFont.systemFont(ofSize: (titleLabel?.font.pointSize)!)
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.text = pickerTitle
        titleLabel?.textColor = Colors.bottomLine
        pickerContainerView?.contentView.addSubview(titleLabel!)
    }
    
    private func addDatePicker(_ mode: UIDatePicker.Mode, isMaxToday: Bool, isMinToday: Bool){
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 50, width: PickerConstants.pickerWidth, height: 200))
        datePicker?.setValue(Colors.bottomLine, forKeyPath: "textColor")
        datePicker?.datePickerMode = mode
        if isMaxToday {
            let calendar = Calendar(identifier: .gregorian)
            var comps = DateComponents()
            comps.year = -21
            let maxDate = calendar.date(byAdding: comps, to: Date())
            datePicker?.maximumDate = maxDate
        }
        if isMinToday {
            datePicker?.minimumDate = Date()
        }
        pickerContainerView?.contentView.addSubview(datePicker!)
    }
    
    @objc func actionCancel(){
        delegate?.didCancelPickingDate?()
        close()
    }
    
    @objc func actionSelect(){
        delegate?.didPickDate(data: datePicker?.date, mode: pickerMode ?? .date)
        close()
    }
    
    private func close(){
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    private func addButtons(){
        cancelButton = UIButton(frame: CGRect(x: 0, y: 251, width: (PickerConstants.pickerWidth-1)/2, height: 49))
        cancelButton?.addTarget(self, action: #selector(actionCancel), for: UIControl.Event.touchUpInside)
        cancelButton?.setTitle(cancelTitle, for: UIControl.State.normal)
        cancelButton?.setTitleColor(view.tintColor, for: UIControl.State.normal)
        cancelButton?.setTitleColor(Colors.bottomLine, for: .normal)
        pickerContainerView?.contentView.addSubview(cancelButton!)
        
        pickButton = UIButton(frame: CGRect(x: (PickerConstants.pickerWidth+1)/2, y: 251, width: (PickerConstants.pickerWidth-1)/2, height: 49))
        pickButton?.addTarget(self, action: #selector(actionSelect), for: UIControl.Event.touchUpInside)
        pickButton?.setTitle(pickTitle, for: UIControl.State.normal)
        pickButton?.setTitleColor(Colors.bottomLine, for: .normal)
        pickerContainerView?.contentView.addSubview(pickButton!)
    }
    
    private func addHorizontalSeperator(){
        let seperator = UIView(frame: CGRect(x: 0, y: 250, width: PickerConstants.pickerWidth, height: 1))
        seperator.backgroundColor = UIColor.gray
        pickerContainerView?.contentView.addSubview(seperator)
    }
    
    private func addVerticalSeperator(){
        let seperator = UIView(frame: CGRect(x: (PickerConstants.pickerWidth-1)/2, y: 250, width: 1, height: 49))
        seperator.backgroundColor = UIColor.gray
        pickerContainerView?.contentView.addSubview(seperator)
    }
    
}
