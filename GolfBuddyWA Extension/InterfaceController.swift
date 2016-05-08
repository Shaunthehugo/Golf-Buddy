//
//  InterfaceController.swift
//  GolfBuddyWA Extension
//
//  Created by Shaun Dougherty on 5/4/16.
//  Copyright © 2016 foru. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    var sharedDefaults = NSUserDefaults(suiteName: "group.com.foru.GolfBuddy")

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        self.pushControllerWithName("strokeController", context: self.sharedDefaults!.integerForKey("holeNum"))
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func fullRoundTapped() {
        self.pushControllerWithName("strokeController", context: 18)
    }
    
    @IBAction func halfRoundTapped() {
        self.pushControllerWithName("strokeController", context: 9)
    }
    
}
