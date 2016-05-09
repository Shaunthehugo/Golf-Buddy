//
//  StatsViewController.swift
//  GolfBuddy
//
//  Created by Shaun Dougherty on 5/4/16.
//  Copyright © 2016 foru. All rights reserved.
//

import UIKit
import WatchConnectivity

class StatsViewController: UIViewController, WCSessionDelegate {
	
	@IBOutlet weak var eagleStatLabel: UILabel!
	@IBOutlet weak var birdieStatLabel: UILabel!
	@IBOutlet weak var parStatLabel: UILabel!
	@IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!

    var eagles: Int = 0
    var birdies: Int = 0
    var pars: Int = 0
    var strokes: Int = 0
    var games: Int = 0
    var average: Int = 0
    var session: WCSession!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        configureSession()
        
        self.resetButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.resetButton.layer.cornerRadius = 19.5
        self.resetButton.clipsToBounds = true
	}
	
    
    func configureSession() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activateSession()
        }
    }
    
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)

        configureSession()
        
//        if self.sharedDefaults?.integerForKey("strokes") == 0 {
			averageLabel.text = "Average: 0"
            
            self.average = self.strokes/self.games
            
            averageLabel.text = "Average: \(average)"
//		}

        eagleStatLabel.text = "\(self.eagles)"
        birdieStatLabel.text = "\(self.birdies)"
        parStatLabel.text = "\(self.pars)"
	}
	
	@IBAction func resetTapped(sender: AnyObject) {
		eagleStatLabel.text = "0"
		birdieStatLabel.text = "0"
		parStatLabel.text = "0"
		averageLabel.text = "Average: 0"
	}
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}
}
