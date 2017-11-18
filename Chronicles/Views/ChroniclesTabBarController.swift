//
//  ChroniclesTabBarController.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/2/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import UIKit

class ChroniclesTabBarController : UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabBarOne = HomeViewController(fromTable: false)
        let tabBarTwo = HomeTableViewController()
        
        tabBarOne.view.backgroundColor = Color.backgroundColor
        
        tabBarOne.title = "Home"
        tabBarTwo.title = "Fitness"
        
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "ic_home"), selectedImage: UIImage(named: "ic_home"))
        let fitnessTabBarItem = UITabBarItem(title: "Fitness", image: UIImage(named: "ic_fitness_center"), selectedImage: UIImage(named: "ic_fitness_center"))
        
        
        tabBarOne.tabBarItem = homeTabBarItem
        tabBarTwo.tabBarItem = fitnessTabBarItem
        
        let tabControllers = [tabBarOne, tabBarTwo]
        
        self.viewControllers = tabControllers.map{NavigationController(rootViewController: $0)}
    }
}