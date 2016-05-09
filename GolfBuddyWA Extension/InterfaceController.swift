//
//  InterfaceController.swift
//  GolfBuddyWA Extension
//
//  Created by Shaun Dougherty on 5/4/16.
//  Copyright © 2016 foru. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var session: WCSession!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        configureSession()
    }

    func configureSession() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activateSession()
        }
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
