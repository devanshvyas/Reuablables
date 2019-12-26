//
//  Timeline.swift
//  PumaHub
//
//  Created by Devansh Vyas on 12/07/19.
//  Copyright © 2019 Concentric Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

class Timeline {
    var title: String!
    var timeString: String!
    var descriptionText: String?
    var actionPerformed: [String]?
    var titleColor: UIColor? = Colors.lightBlack
    var actionItemColor: UIColor? = Colors.lightBlack
    
    init(title: String,timeString: String,desc: String,actionPerformed: [String], titleColor: UIColor,actionItemColor: UIColor) {
        self.title = title
        self.timeString = timeString
        self.descriptionText = desc
        self.actionPerformed = actionPerformed
        self.titleColor = titleColor
        self.actionItemColor = actionItemColor
    }
    class func getStaticTimeline() -> [Timeline] {
        return [
            Timeline(title: "Order Created", timeString: "Apr", desc: "Order details are subject to area which you have selected", actionPerformed: [], titleColor: Colors.lightBlack,actionItemColor: Colors.lightBlack),
            Timeline(title: "Tank Reading", timeString: "Mar", desc: "", actionPerformed: ["Order Delivered","Order Loaded"], titleColor: Colors.lightBlack,actionItemColor: Colors.lightBlack),
            Timeline(title: "Order Created", timeString: "Feb", desc: "", actionPerformed: ["Maintenance Req. Raised"], titleColor: Colors.darkGreen,actionItemColor: Colors.lightBlack),
            Timeline(title: "", timeString: "Jan", desc: "", actionPerformed: ["Tank Dips Missed","Credit Note Received","","","","","","Price Book Updated"], titleColor: Colors.lightBlack,actionItemColor: Colors.darkGreen)
        ]
    }
}

class TimeLineData: Codable {
    var timeline: [TimelineList]?
}
class TimelineList: Codable {
    var time: String?
    var title: String?
    var details: String?
    var actionPerformed: [String]?
}
