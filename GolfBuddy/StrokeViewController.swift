//
//  StrokeViewController.swift
//  GolfBuddy
//
//  Created by Shaun Dougherty on 5/4/16.
//  Copyright © 2016 foru. All rights reserved.
//

import UIKit
import WatchConnectivity

class StrokeViewController: UIViewController, WCSessionDelegate {
	
	var holes = 0
	var games = 0
	var holeNum = 1
	var stroke = 0
	var strokes = 0
    var session: WCSession!
	
	@IBOutlet weak var addStrokeButton: UIButton!
	@IBOutlet weak var subtractStrokeButton: UIButton!
	@IBOutlet weak var strokeLabel: UILabel!
	@IBOutlet weak var holeLabel: UILabel!
	@IBOutlet weak var nextHoleButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
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
    
    func configureSession() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activateSession()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.holeLabel.text = "\(holeNum)"
        self.strokeLabel.text = "\(stroke)"
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
		}
	}
    
        
    func showStrokeType() {
        var eagleAction: UIAlertAction
        var birdieAction: UIAlertAction
        var parAction: UIAlertAction
        
            eagleAction = UIAlertAction(title: "Eagle", style: .Default, handler: { (UIAlertAction) in
            })
        
            birdieAction = UIAlertAction(title: "Birdie", style: .Default, handler: { (UIAlertAction) in
            })

            parAction = UIAlertAction(title: "Par", style: .Default, handler: { (UIAlertAction) in
            })
        
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