//
//  HomeVC.swift
//  Reusablity
//
//  Created by Devansh Vyas on 04/06/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var gameView: GameDisk!
    
    var initialTimer = 10
    var users = [User]()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.diskType = .getReadyTieBreaker
        gameView.users = users
        startGame()
    }

    @IBAction func addUser(_ sender: UIButton) {
        user.profilePic = users.count/2 == 0 ? "https://dummyimage.com/300.png/09f/fff" : "https://dummyimage.com/300.png/09f/fff"
        users.append(user)
        self.gameView.diskType = .round
        gameView.users = users
    }
    
    @IBAction func removeUser(_ sender: UIButton) {
        guard users.count > 0 else { return }
        users.removeLast()
        self.gameView.diskType = .round
        gameView.users = users
    }
    
    func startGame() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if self.initialTimer <= 0 {
                timer.invalidate()
                self.gameView.diskType = .round
                self.gameView.lblRoundNumber.text = "1"
                
            } else {
                self.gameView.lblGetReadySeconds.text = "\(self.initialTimer)"
                self.initialTimer = self.initialTimer - 1
            }
        }
    }
}

