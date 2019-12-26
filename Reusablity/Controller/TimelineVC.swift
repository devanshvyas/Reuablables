//
//  HomeVC.swift
//  Reusablity
//
//  Created by Devansh Vyas on 04/06/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit

class TimelineVC: BaseVC {
    @IBOutlet weak var timelineView: TimelineView!
    
    override func viewDidLoad() {
        timelineView.timelineData = Timeline.getStaticTimeline()
    }
    
    @IBAction func logout(_ sender: RoundedButton) {
        Defaults.shared.setData(key: .isLoggedIn, data: false)
        navigationController?.popToRootViewController(animated: true)
    }
}

