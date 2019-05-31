//
//  Defaults.swift
//  Reusablity
//
//  Created by Devansh Vyas on 29/05/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit

enum DefaultKeys: String {
    case isLoggedIn
    case username
    case numberOfDivisions
}

class Defaults {
    static let shared = Defaults()
    let defaults = UserDefaults.standard
    
    func getData(key: DefaultKeys) -> Any? {
        return defaults.value(forKey: key.rawValue)
    }
    
    func setData(key: DefaultKeys, data: Any) {
        return defaults.set(data, forKey: key.rawValue)
    }
}


