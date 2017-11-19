//
//  HomeTableViewController.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/2/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import UIKit


class JobsTableViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, DismissalDelegate {
    var myTableView: UITableView  =   UITableView()
    var itemsToLoad: [String] = ["One", "Two", "Three"]
    
    let taskCellIdentifier = "taskCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        var index = 0
        
        while(index < 50){
            itemsToLoad.append(String(index))
            index += 1
        }
        
        myTableView.allowsMultipleSelection = true
        myTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: taskCellIdentifier)
        
        self.view.addSubview(myTableView)
        
        let addBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(sender:)))
        self.navigationItem.rightBarButtonItem = addBarItem
    }
    
    @IBAction func addTapped(sender:UIBarButtonItem){
        print("bar button tapped")
        
        let vc =  JobDataEntryViewController()
//        let navController = UINavigationController(rootViewController: vc)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        //finally presenting the dialog box
//        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
       
        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
            print("more button tapped")
        }
        more.backgroundColor = .lightGray
        
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
            print("favorite button tapped")
        }
        favorite.backgroundColor = .orange
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
            print("share button tapped")
        }
        share.backgroundColor = .blue
        
        return [share, favorite, more]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemsToLoad.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: taskCellIdentifier, for: indexPath as IndexPath)
        
        cell.textLabel?.text = self.itemsToLoad[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = Color.primaryColor
            cell.textLabel?.textColor = Color.secondaryColor
        }else{
            cell.backgroundColor = Color.secondaryColor
            cell.textLabel?.textColor = Color.primaryColor
        }
        
        if cell.isSelected {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = .checkmark
        }
        
        print("User selected table row \(indexPath.row) and item \(itemsToLoad[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath){
            cell.accessoryType = .none
        }
    }

}
