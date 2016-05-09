//
//  StrokeInterfaceController.swift
//  GolfBuddy
//
//  Created by Shaun Dougherty on 5/5/16.
//  Copyright © 2016 Shaun Dougherty. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class StrokeInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var holes = 0
    var games = 0
    var holeNum = 1
    var stroke = 0
    var strokes = 0
    var session: WCSession!
    
    @IBOutlet var addStrokeButton: WKInterfaceButton!
    @IBOutlet var subtractStrokeButton: WKInterfaceButton!
    @IBOutlet var holeLabel: WKInterfaceLabel!
    @IBOutlet var strokeLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        holes = (context as? Int)!
        
        configureSession()
        
        holeLabel.setText("\(holeNum) of \(holes)")
    }
    
    func configureSession() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activateSession()
        }
    }
    
    @IBAction func addStrokeTapped() {
        stroke+=1
        strokeLabel.setText("\(stroke)")
    }
    
    @IBAction func subtractStrokeTapped() {
        stroke-=1
        strokeLabel.setText("\(stroke)")
    }

    @IBAction func nextHoleTapped() {
        showStrokeType()
        strokes+=stroke
        if holeNum == holes {
            addStrokeButton.setEnabled(false)
            subtractStrokeButton.setEnabled(false)
            
            showPopUp()
        }
        
        holeNum+=1
        holeLabel.setText("\(holeNum) of \(holes)")
        strokeLabel.setText("0")
        stroke = 0
    }
    
    func showStrokeType() {
        var eagleAction: WKAlertAction
        var birdieAction: WKAlertAction
        var parAction: WKAlertAction
        let h0 = {print()}
        
            eagleAction = WKAlertAction(title: "Eagle", style: .Default) { () -> Void in
                
            }
        
            birdieAction = WKAlertAction(title: "Birdie", style: .Default) { () -> Void in
            }
        
            parAction = WKAlertAction(title: "Par", style: .Default) { () -> Void in
            }
        
        let noneAction = WKAlertAction(title: "None", style: .Default, handler: h0)
        
        presentAlertControllerWithTitle("", message: "What did you get?", preferredStyle: .Alert, actions: [eagleAction, birdieAction, parAction, noneAction])
    }
    
    func showPopUp() {
        holeLabel.setText("\(holeNum) of \(holes)")
        let h0 = {print("OK")}
        
        let action1 = WKAlertAction(title: "OK", style: .Default, handler: h0)
        
        presentAlertControllerWithTitle("", message: "Your score was \(strokes).", preferredStyle: .ActionSheet, actions: [action1])
    }
}
