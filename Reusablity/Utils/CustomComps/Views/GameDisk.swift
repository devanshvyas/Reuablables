//
//  GameDisk.swift
//  SNDRND
//
//  Created by Zaid Pathan on 02/01/19.
//  Copyright © 2019 Solution Analysts Pvt. Ltd. All rights reserved.
//

import UIKit

enum GameDiskType {
    case getReady
    case getReadyTieBreaker
    case nowPlaying
    case round
}

class GameDisk: UIView {
    
    @IBOutlet var gameDisk: UIView!
    @IBOutlet weak var centerView: RoundedView!
    @IBOutlet weak var pieChartBackgroundView: UIView!
    @IBOutlet weak var crown: UIImageView!
    
    //Get ready
    @IBOutlet weak var getReadyContainer: UIView!
    @IBOutlet weak var lblGetReadySeconds: UILabel!
    @IBOutlet weak var lblRndStartsIn: UILabel!
    var roundAboutToStart = 0 {
        didSet {
            lblRndStartsIn.text = "Rnd \(roundAboutToStart) Starts in ..."
        }
    }
    
    //Round
    @IBOutlet weak var roundContainer: UIView!
    @IBOutlet weak var lblRoundNumber: UILabel!
    
    //Now playing
    @IBOutlet weak var nowPlayingContainer: UIView!
    @IBOutlet weak var imgNowPlaying: UIImageView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    var users: [User] = [] {
        didSet {
            for subview in pieChartView.subviews {
                if subview.tag == 99 {
                    subview.removeFromSuperview()
                }
            }
            var segments = [Segment]()
            for user in users {
                if let profilePic = user.profilePic {
                    segments.append(Segment(imageURL: profilePic, isNowPlaying: user.isNowPlaying))
                }
            }
            pieChartView?.segments = segments
            
            pieChartBackgroundView.isHidden = (users.count != 2)
        }
    }
    
    var diskType: GameDiskType = .getReady {
        didSet {
            setupView(diskType: diskType)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.size.width/2
    }
    
    //# MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup(nibName: "GameDisk")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup(nibName: "GameDisk")
    }
    
    //# MARK: - Private methods
    private func setupView(diskType: GameDiskType) {
        roundContainer.isHidden = true
        getReadyContainer.isHidden = true
        nowPlayingContainer.isHidden = true
        crown.isHidden = true
        
        switch diskType {
        case .getReady:
            getReadyContainer.isHidden = false
        case .getReadyTieBreaker:
            getReadyContainer.isHidden = false
            crown.isHidden = false
        case .nowPlaying:
            nowPlayingContainer.isHidden = false
        case .round:
            roundContainer.isHidden = false
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        centerView.cornerRadius = centerView.frame.size.width/2
        pieChartBackgroundView.layer.cornerRadius = pieChartBackgroundView.frame.width/2
    }
    
}
