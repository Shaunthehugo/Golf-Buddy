//
//  StrokeInterfaceController.swift
//  GolfBuddy
//
//  Created by Shaun Dougherty on 5/5/16.
//  Copyright © 2016 Shaun Dougherty. All rights reserved.
//

import WatchKit
import Foundation
import CoreData

class StrokeInterfaceController: WKInterfaceController {
    
    var holes = 0
    var games = 0
    var holeNum = 1
    var stroke = 0
    var strokes = 0
    var sharedDefaults = NSUserDefaults(suiteName: "group.com.foru.GolfBuddy.AppShare")
    
    @IBOutlet var addStrokeButton: WKInterfaceButton!
    @IBOutlet var subtractStrokeButton: WKInterfaceButton!
    @IBOutlet var holeLabel: WKInterfaceLabel!
    @IBOutlet var strokeLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        holes = (context as? Int)!
        
        holeLabel.setText("\(holeNum) of \(holes)")
        strokeLabel.setText("0")
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
            
            self.sharedDefaults?.synchronize()
        }
        
        holeNum+=1
        holeLabel.setText("\(holeNum) of \(holes)")
        strokeLabel.setText("0")
        stroke = 0
        
        self.sharedDefaults?.synchronize()
    }
    
    func showStrokeType() {
        var eagleAction: WKAlertAction
        var birdieAction: WKAlertAction
        var parAction: WKAlertAction
        let h0 = {print()}
        
        if self.sharedDefaults?.objectForKey("eagles") == nil {
            eagleAction = WKAlertAction(title: "Eagle", style: .Default) { () -> Void in
                self.sharedDefaults?.setObject(1, forKey: "eagles")
            }
        } else {
            eagleAction = WKAlertAction(title: "Eagle", style: .Default) { () -> Void in
                self.sharedDefaults?.setObject(1+(self.sharedDefaults?.objectForKey("eagels") as? Int)!, forKey: "eagles")
            }
        }
        
        if self.sharedDefaults?.objectForKey("birdies") == nil {
            birdieAction = WKAlertAction(title: "Birdie", style: .Default) { () -> Void in
                self.sharedDefaults?.setObject(1, forKey: "birdies")
            }
        } else {
            birdieAction = WKAlertAction(title: "Birdie", style: .Default) { () -> Void in
                self.sharedDefaults?.setObject(1+(self.sharedDefaults?.objectForKey("birdies") as? Int)!, forKey: "birdies")
            }
        }
        
        if self.sharedDefaults?.objectForKey("pars") == nil {
            parAction = WKAlertAction(title: "Par", style: .Default) { () -> Void in
                self.sharedDefaults?.setObject(1, forKey: "pars")
            }
        } else {
            parAction = WKAlertAction(title: "Par", style: .Default) { () -> Void in
                self.sharedDefaults?.setObject(1+(self.sharedDefaults?.objectForKey("pars") as? Int)!, forKey: "pars")
            }
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
