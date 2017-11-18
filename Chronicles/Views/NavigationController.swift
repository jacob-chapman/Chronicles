//
//  NavigationController.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/6/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import UIKit

class NavigationController : UINavigationController, UINavigationControllerDelegate {

    let navBarTitle = "Roo Dawg"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.topItem?.title = navBarTitle
    }
}
