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
    var sharedDefaults = NSUserDefaults(suiteName: "group.com.foru.GolfBuddy")
	
	@IBOutlet weak var addStrokeButton: UIButton!
	@IBOutlet weak var subtractStrokeButton: UIButton!
	@IBOutlet weak var strokeLabel: UILabel!
	@IBOutlet weak var holeLabel: UILabel!
	@IBOutlet weak var nextHoleButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
		navigationItem.backBarButtonItem?.title = "Cancel"
		navigationItem.title = "Round of \(holes)"
        
        self.sharedDefaults?.setInteger(holes, forKey: "holes")
		
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.sharedDefaults?.synchronize()
        self.sharedDefaults?.setBool(true, forKey: "gameStarted")
        
        self.holeNum = self.sharedDefaults!.integerForKey("holeNum")
        self.holeLabel.text = "\(holeNum)"
        
        self.stroke = self.sharedDefaults!.integerForKey("stroke")
        self.strokeLabel.text = "\(stroke)"
        
        self.strokes = self.sharedDefaults!.integerForKey("strokes")
    }
	
	@IBAction func addStrokeTapped(sender: AnyObject) {
		stroke+=1
		strokeLabel.text = "\(stroke)"
        self.sharedDefaults?.setInteger(stroke, forKey: "stroke")
	}
	
	@IBAction func subtractStrokeTapped(sender: AnyObject) {
        stroke-=1
        strokeLabel.text = "\(stroke)"
        self.sharedDefaults?.setInteger(stroke, forKey: "stroke")
	}
	
	@IBAction func nextHoleTapped(sender: AnyObject) {
		self.sharedDefaults?.setInteger(holes, forKey: "holes")
        self.sharedDefaults?.setInteger(strokes, forKey: "strokes")
        
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
            
            if self.sharedDefaults?.integerForKey("strokes") == nil {
                self.sharedDefaults?.setInteger(strokes, forKey: "strokes")
            } else {
                self.sharedDefaults?.setInteger(strokes+(self.sharedDefaults?.integerForKey("strokes"))!, forKey: "strokes")
            }
            
            if self.sharedDefaults?.integerForKey("games") == nil {
                self.sharedDefaults?.setInteger(1, forKey: "games")
            } else {
                self.sharedDefaults?.setInteger(1+(self.sharedDefaults?.integerForKey("games"))!, forKey: "games")
            }
		}
        
        self.sharedDefaults?.synchronize()
	}
    
        
    func showStrokeType() {
        var eagleAction: UIAlertAction
        var birdieAction: UIAlertAction
        var parAction: UIAlertAction
        
        if self.sharedDefaults?.integerForKey("eagles") == nil {
            eagleAction = UIAlertAction(title: "Eagle", style: .Default, handler: { (UIAlertAction) in
                self.sharedDefaults?.setInteger(1, forKey: "eagles")
            })
        } else {
            eagleAction = UIAlertAction(title: "Eagle", style: .Default, handler: { (UIAlertAction) in
                self.sharedDefaults?.setInteger(1+(self.sharedDefaults?.integerForKey("eagles"))!, forKey: "eagles")
            })
        }
        
        if self.sharedDefaults?.integerForKey("birdies") == nil {
            birdieAction = UIAlertAction(title: "Birdie", style: .Default, handler: { (UIAlertAction) in
                self.sharedDefaults?.setInteger(1, forKey: "birdies")
            })
        } else {
            birdieAction = UIAlertAction(title: "Birdie", style: .Default, handler: { (UIAlertAction) in
                self.sharedDefaults?.setInteger(1+(self.sharedDefaults?.integerForKey("birdies"))!, forKey: "birdies")
            })
        }
        
        if self.sharedDefaults?.integerForKey("pars") == nil {
            parAction = UIAlertAction(title: "Par", style: .Default, handler: { (UIAlertAction) in
                self.sharedDefaults?.setInteger(1, forKey: "pars")
            })
        } else {
            parAction = UIAlertAction(title: "Par", style: .Default, handler: { (UIAlertAction) in
                self.sharedDefaults?.setInteger(1+(self.sharedDefaults?.integerForKey("pars"))!, forKey: "pars")
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