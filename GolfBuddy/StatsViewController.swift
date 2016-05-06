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
    var sharedDefaults = NSUserDefaults(suiteName: "group.com.foru.GolfBuddy.AppShare")
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        self.resetButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.resetButton.layer.cornerRadius = 19.5
        self.resetButton.clipsToBounds = true
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)

        self.sharedDefaults!.synchronize()
        
        if self.sharedDefaults?.objectForKey("strokes") == nil {
			averageLabel.text = "Average: 0"
		} else {
            if self.sharedDefaults?.objectForKey("strokes") == nil {
                self.sharedDefaults?.setObject(0, forKey: "strokes")
                self.strokes = 0
            } else {
                self.strokes = (self.sharedDefaults!.objectForKey("strokes") as? Int)!
            }
            
            if self.sharedDefaults!.objectForKey("games") == nil {
                self.sharedDefaults!.setObject(0, forKey: "games")
                self.games = 0
            } else {
                self.games = (self.sharedDefaults!.objectForKey("games") as? Int)!
            }
            
            self.average = strokes/games
            
            averageLabel.text = "Average: \(average)"
		}
        
        if self.sharedDefaults!.objectForKey("birdies") == nil {
            self.sharedDefaults!.setObject(0, forKey: "birdies")
            self.birdies = 0
        } else {
            self.birdies = (self.sharedDefaults!.objectForKey("birdies") as? Int)!
        }
        
        if self.sharedDefaults!.objectForKey("pars") == nil {
            self.sharedDefaults!.setObject(0, forKey: "pars")
            self.pars = 0
        } else {
            self.pars = (self.sharedDefaults!.objectForKey("pars") as? Int)!
        }
        
        if self.sharedDefaults!.objectForKey("eagles") == nil {
            self.sharedDefaults!.setObject(0, forKey: "eagles")
            self.eagles = 0
        } else {
            self.eagles = (self.sharedDefaults!.objectForKey("eagles") as? Int)!
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
        
        self.sharedDefaults!.setObject(0, forKey: "strokes")
        self.sharedDefaults!.setObject(0, forKey: "games")
        self.sharedDefaults!.setObject(0, forKey: "eagles")
        self.sharedDefaults!.setObject(0, forKey: "birdies")
        self.sharedDefaults!.setObject(0, forKey: "pars")
	}
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}
}
