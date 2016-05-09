//
//  ViewController.swift
//  GolfBuddy
//
//  Created by Shaun Dougherty on 5/4/16.
//  Copyright © 2016 foru. All rights reserved.
//

import UIKit
import WatchConnectivity

class GameViewController: UIViewController, WCSessionDelegate {
	
    var session: WCSession!
    
	@IBOutlet weak var fullRoundButton: UIButton!
	@IBOutlet weak var halfRoundButton: UIButton!
	
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		configureSession()
        
        self.fullRoundButton.layer.borderColor = UIColor.whiteColor().CGColor
		self.fullRoundButton.layer.cornerRadius = 17.5
		self.fullRoundButton.clipsToBounds = true
		
		self.halfRoundButton.layer.borderColor = UIColor.whiteColor().CGColor
		self.halfRoundButton.layer.cornerRadius = 17.5
		self.halfRoundButton.clipsToBounds = true
	}
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        configureSession()
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        if (message["gameStarted"] as? Bool) == true {
            let strokeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("strokeVC") as! StrokeViewController
            strokeVC.holes = (message["holes"] as? Int)!
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
    
    func configureSession() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activateSession()
        }
    }
}

