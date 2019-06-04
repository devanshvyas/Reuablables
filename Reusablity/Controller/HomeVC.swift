//
//  HomeVC.swift
//  Reusablity
//
//  Created by Devansh Vyas on 04/06/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {

    @IBOutlet weak var gameView: GameDisk!
    @IBOutlet weak var addRemoveView: UIStackView!
    @IBOutlet weak var resultButton: RoundedButton!
    
    var initialTimer = 5
    var users = [User]()
    var user = User()
    
    var hideButtons: Bool = true {
        didSet {
            addRemoveView.isHidden = hideButtons
            resultButton.isHidden = hideButtons
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.diskType = .getReady
        addUser()
        gameView.users = users
        startGame(type: .getReady)
    }

    @IBAction func addUser(_ sender: UIButton) {
        addUser()
        gameView.users = users
    }
    
    @IBAction func removeUser(_ sender: UIButton) {
        guard users.count > 1 else { return }
        users.removeLast()
        gameView.users = users
    }
    
    @IBAction func resultButtonPressed(_ sender: RoundedButton) {
        gameView.diskType = .getReadyTieBreaker
        while users.count > 2 {
            users.removeLast()
        }
        gameView.users = users
        initialTimer = 5
        startGame(type: .getReadyTieBreaker)
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        Defaults.shared.setData(key: .isLoggedIn, data: false)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func startGame(type: GameDiskType) {
        self.hideButtons = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if self.initialTimer <= 0 {
                timer.invalidate()
                let typeCondition = type == .getReadyTieBreaker
                self.gameView.diskType = .round
                self.gameView.lblRoundNumber.text = typeCondition ? "2" : "1"
                self.hideButtons = typeCondition
            } else {
                self.gameView.lblGetReadySeconds.text = "\(self.initialTimer)"
                self.initialTimer = self.initialTimer - 1
            }
        }
    }
    
    func addUser() {
        user.profilePic = users.count/2 == 0 ? "https://dummyimage.com/300.png/09f/fff" : "https://dummyimage.com/300.png/09f/fff"
        users.append(user)
    }
}

