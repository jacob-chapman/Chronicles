//
//  JobDataEntryViewController.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/18/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import UIKit

class JobDataEntryViewController : UIViewController, Dismissable {
    
    var dismissalDelegate: DismissalDelegate?
    
    lazy var jobNameTextField: UITextField! = {
       let view = UITextField()
        view.placeholder = "Job Name"
        view.backgroundColor = UIColor.white
        view.textColor = UIColor.black
        return view
    }()
    
    lazy var dueDateField: UIDatePicker! = {
       let view = UIDatePicker()
        view.datePickerMode = UIDatePickerMode.dateAndTime
        return view
    }()
    
    lazy var jobNotesTextField: UITextField! = {
        let view = UITextField()
        view.placeholder = "Job Name"
        view.backgroundColor = UIColor.white
        view.textColor = UIColor.black
        return view
    }()
    
    //todo person assigned to
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        self.hidesBottomBarWhenPushed = true
        
        // adjust the navigation Bar
        self.navigationController?.navigationBar.topItem?.title = "Create Job"
        
//        let leftBarItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed(sender:)))
        let rightBarItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(savePressed(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightBarItem
//        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    // MARK: Constraints
    
    private func setConstraints(){
        
        //job name
        NSLayoutConstraint(
            item: jobNameTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: 15).isActive = true
        
    }
    
    
    // MARK: Nav bar button actions
    
    @IBAction func savePressed(sender: UIBarButtonItem){
    
    }
    
    @IBAction func cancelPressed(sender: UIBarButtonItem){
//        dismissalDelegate?.finishedShowing(viewController: self.navigationController!)
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
