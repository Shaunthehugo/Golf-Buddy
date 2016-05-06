//
//  StrokeViewController.swift
//  GolfBuddy
//
//  Created by Shaun Dougherty on 5/4/16.
//  Copyright © 2016 foru. All rights reserved.
//

import UIKit
import CoreData

class StrokeViewController: UIViewController {
	
	var holes = 0
	var games = 0
	var holeNum = 1
	var stroke = 0
	var strokes = 0
    var sharedDefaults = NSUserDefaults(suiteName: "group.com.foru.GolfBuddy.AppShare")
	
	@IBOutlet weak var addStrokeButton: UIButton!
	@IBOutlet weak var subtractStrokeButton: UIButton!
	@IBOutlet weak var strokeLabel: UILabel!
	@IBOutlet weak var holeLabel: UILabel!
	@IBOutlet weak var nextHoleButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        self.sharedDefaults?.synchronize()
        
		navigationItem.backBarButtonItem?.title = "Cancel"
		navigationItem.title = "Round of \(holes)"
		
		self.addStrokeButton.layer.borderColor = UIColor.whiteColor().CGColor
		self.addStrokeButton.layer.cornerRadius = 50
		self.addStrokeButton.clipsToBounds = true
		
		self.subtractStrokeButton.layer.borderColor = UIColor.whiteColor().CGColor
		self.subtractStrokeButton.layer.cornerRadius = 50
		self.subtractStrokeButton.clipsToBounds = true
		
		self.nextHoleButton.layer.borderColor = UIColor.whiteColor().CGColor
		self.nextHoleButton.layer.cornerRadius = 13.5
		self.nextHoleButton.clipsToBounds = true
		
		holeLabel.text = "\(holeNum) of \(holes)"
		strokeLabel.text = "0"
	}
	
	@IBAction func addStrokeTapped(sender: AnyObject) {
		stroke+=1
		strokeLabel.text = "\(stroke)"
	}
	
	@IBAction func subtractStrokeTapped(sender: AnyObject) {
        stroke-=1
        strokeLabel.text = "\(stroke)"
	}
	
	@IBAction func nextHoleTapped(sender: AnyObject) {
		strokes+=stroke
        showStrokeType()
        holeNum+=1
        holeLabel.text = "\(holeNum) of \(holes)"
        strokeLabel.text = "0"
        stroke = 0
        
		if holeNum == holes {
			addStrokeButton.enabled = false
			subtractStrokeButton.enabled = false
			nextHoleButton.enabled = false
			let alertView = UIAlertController(title: "", message: "Your score was \(strokes).", preferredStyle: UIAlertControllerStyle.Alert)
			alertView.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
			self.presentViewController(alertView, animated: true, completion: nil)
            
            if self.sharedDefaults?.objectForKey("strokes") == nil {
                self.sharedDefaults?.setObject(strokes, forKey: "strokes")
            } else {
                self.sharedDefaults?.setObject(strokes+(self.sharedDefaults?.objectForKey("strokes") as? Int)!, forKey: "strokes")
            }
            
            if self.sharedDefaults?.objectForKey("games") == nil {
                self.sharedDefaults?.setObject(1, forKey: "games")
            } else {
                self.sharedDefaults?.setObject(1+(self.sharedDefaults?.objectForKey("games") as? Int)!, forKey: "games")
            }
		}
        
        self.sharedDefaults?.synchronize()
	}
    
        
    func showStrokeType() {
        var eagleAction: UIAlertAction
        var birdieAction: UIAlertAction
        var parAction: UIAlertAction
        
        if self.sharedDefaults?.objectForKey("eagles") == nil {
            eagleAction = UIAlertAction(title: "Eagle", style: .Default, handler: { (UIAlertAction) in
                self.sharedDefaults?.setObject(1, forKey: "eagles")
            })
        } else {
            eagleAction = UIAlertAction(title: "Eagle", style: .Default, handler: { (UIAlertAction) in
                self.sharedDefaults?.setObject(1+(self.sharedDefaults?.objectForKey("eagles") as? Int)!, forKey: "eagles")
            })
        }
        
        if self.sharedDefaults?.objectForKey("birdies") == nil {
            birdieAction = UIAlertAction(title: "Birdie", style: .Default, handler: { (UIAlertAction) in
                self.sharedDefaults?.setObject(1, forKey: "birdies")
            })
        } else {
            birdieAction = UIAlertAction(title: "Birdie", style: .Default, handler: { (UIAlertAction) in
                self.sharedDefaults?.setObject(1+(self.sharedDefaults?.objectForKey("birdies") as? Int)!, forKey: "birdies")
            })
        }
        
        if self.sharedDefaults?.objectForKey("pars") == nil {
            parAction = UIAlertAction(title: "Par", style: .Default, handler: { (UIAlertAction) in
                self.sharedDefaults?.setObject(1, forKey: "pars")
            })
        } else {
            parAction = UIAlertAction(title: "Par", style: .Default, handler: { (UIAlertAction) in
                self.sharedDefaults?.setObject(1+(self.sharedDefaults?.objectForKey("pars") as? Int)!, forKey: "pars")
            })
        }
        
        let noneAction = UIAlertAction(title: "None", style: .Default) { (UIAlertAction) in
            print("OK")
        }
        
        let strokeAlert = UIAlertController(title: "", message: "What did you get?", preferredStyle: UIAlertControllerStyle.Alert)
        strokeAlert.addAction(eagleAction)
        strokeAlert.addAction(birdieAction)
        strokeAlert.addAction(parAction)
        strokeAlert.addAction(noneAction)
        
        presentViewController(strokeAlert, animated: true, completion: nil)
    }
}