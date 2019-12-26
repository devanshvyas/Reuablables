//
//  UITableview.swift
//  PumaHub
//
//  Created by Devansh Vyas on 10/07/19.
//  Copyright © 2019 Concentric Pvt. Ltd. All rights reserved.
//

import  UIKit

enum TableViewCellNames: String {
    case TimelineCell
}

extension UITableView {
    
    func registerCell(id: TableViewCellNames) {
        let cellNib = UINib.init(nibName: id.rawValue, bundle: nil)
        register(cellNib, forCellReuseIdentifier: id.rawValue)
    }
  
    func reloadData(_ completion: @escaping () -> Void) {
        reloadData()
        DispatchQueue.main.async { completion() }
    }
    
    func dequeue<T: UITableViewCell>(_ obj: T.Type, for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }
    
    /// Remove Loader in FooterView When pagination is enable
    func removeFooterView() {
        self.tableFooterView = nil
    }
    
}



