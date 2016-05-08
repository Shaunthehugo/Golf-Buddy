//
//  ViewController.swift
//  GolfBuddy
//
//  Created by Shaun Dougherty on 5/4/16.
//  Copyright © 2016 foru. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
	
	@IBOutlet weak var fullRoundButton: UIButton!
	@IBOutlet weak var halfRoundButton: UIButton!
	
    var sharedDefaults = NSUserDefaults(suiteName: "group.com.foru.GolfBuddy")
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.fullRoundButton.layer.borderColor = UIColor.whiteColor().CGColor
		self.fullRoundButton.layer.cornerRadius = 17.5
		self.fullRoundButton.clipsToBounds = true
		
		self.halfRoundButton.layer.borderColor = UIColor.whiteColor().CGColor
		self.halfRoundButton.layer.cornerRadius = 17.5
		self.halfRoundButton.clipsToBounds = true
	}
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if self.sharedDefaults?.boolForKey("gameStarted") == true {
            let strokeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("strokeVC") as! StrokeViewController
            strokeVC.holes = self.sharedDefaults!.integerForKey("holeNum")
            self.navigationController?.pushViewController(strokeVC, animated: true)
        }
    }

	@IBAction func halfRoundTapped(sender: AnyObject) {
		let strokeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("strokeVC") as! StrokeViewController
		strokeVC.holes = 9
		self.navigationController?.pushViewController(strokeVC, animated: true)
	}
	
	@IBAction func fullRoundTapped(sender: AnyObject) {
		let strokeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("strokeVC") as! StrokeViewController
		strokeVC.holes = 18
		self.navigationController?.pushViewController(strokeVC, animated: true)
	}
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}
}

