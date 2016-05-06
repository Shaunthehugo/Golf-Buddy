//
//  NavController.swift
//  GolfBuddy
//
//  Created by Shaun Dougherty on 5/4/16.
//  Copyright © 2016 foru. All rights reserved.
//

import UIKit

class NavController: UINavigationController {
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		UITabBar.appearance().tintColor = UIColor(red: 143.0/250.0, green: 231.0/250.0, blue: 109.0/250.0, alpha: 1)
		UITabBar.appearance().backgroundColor = UIColor.blackColor()
	}
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}
}
