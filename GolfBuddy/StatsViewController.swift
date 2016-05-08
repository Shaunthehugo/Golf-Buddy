//
//  StatsViewController.swift
//  GolfBuddy
//
//  Created by Shaun Dougherty on 5/4/16.
//  Copyright © 2016 foru. All rights reserved.
//

import UIKit
import CoreData

class StatsViewController: UIViewController {
	
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
    var sharedDefaults = NSUserDefaults(suiteName: "group.com.foru.GolfBuddy")
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        self.resetButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.resetButton.layer.cornerRadius = 19.5
        self.resetButton.clipsToBounds = true
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)

        self.sharedDefaults!.synchronize()
        
        if self.sharedDefaults?.integerForKey("strokes") == nil {
			averageLabel.text = "Average: 0"
		} else {
            if self.sharedDefaults?.integerForKey("strokes") == nil {
                self.sharedDefaults?.setInteger(0, forKey: "strokes")
                self.strokes = 0
            } else {
                self.strokes = self.sharedDefaults!.integerForKey("strokes")
            }
            
            if self.sharedDefaults!.integerForKey("games") == 0 {
                self.games = 0
            } else {
                self.games = self.sharedDefaults!.integerForKey("games")
            }
            
            self.average = strokes/games
            
            averageLabel.text = "Average: \(average)"
		}
        
        if self.sharedDefaults!.integerForKey("birdies") == 0 {
            self.birdies = 0
        } else {
            self.birdies = self.sharedDefaults!.integerForKey("birdies")
        }
        
        if self.sharedDefaults!.integerForKey("pars") == 0 {
            self.pars = 0
        } else {
            self.pars = self.sharedDefaults!.integerForKey("pars")
        }
        
        if self.sharedDefaults!.integerForKey("eagles") == 0 {
            self.eagles = 0
        } else {
            self.eagles = self.sharedDefaults!.integerForKey("eagles")
        }

        eagleStatLabel.text = "\(self.eagles)"
        birdieStatLabel.text = "\(self.birdies)"
        parStatLabel.text = "\(self.pars)"
	}
	
	@IBAction func resetTapped(sender: AnyObject) {
		eagleStatLabel.text = "0"
		birdieStatLabel.text = "0"
		parStatLabel.text = "0"
		averageLabel.text = "Average: 0"
        
        self.sharedDefaults!.setInteger(0, forKey: "strokes")
        self.sharedDefaults!.setInteger(0, forKey: "games")
        self.sharedDefaults!.setInteger(0, forKey: "eagles")
        self.sharedDefaults!.setInteger(0, forKey: "birdies")
        self.sharedDefaults!.setInteger(0, forKey: "pars")
	}
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}
}
