//
//  User.swift
//  SNDRND
//
//  Created by Rajan shah on 02/01/19.
//  Copyright © 2019 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit

class User: NSObject, Codable {
    var profilePic: String?
    var isNowPlaying: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case profilePic
        case isNowPlaying
    }
}
