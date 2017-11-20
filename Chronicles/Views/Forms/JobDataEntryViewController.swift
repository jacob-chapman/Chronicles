//
//  JobDataEntryViewController.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/18/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import UIKit

class JobDataEntryViewController : UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var jobsViewModel: JobsViewModel?
    
    let nameTag = 100
    let dueDateTag = 101
    let notesTag = 102
    
    lazy var jobNameTextField: UITextField! = {
       let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Job Name"
        view.backgroundColor = UIColor.white
        view.textColor = UIColor.black
        view.delegate = self
        view.returnKeyType = .continue
        view.tag = nameTag
        return view
    }()
    
    lazy var dueDateField: UIDatePicker! = {
       let view = UIDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.datePickerMode = UIDatePickerMode.dateAndTime
        view.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        return view
    }()
    
    lazy var jobDueDateTextField: UITextField! = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Due Date"
        view.tag = dueDateTag
        view.backgroundColor = UIColor.white
        view.textColor = UIColor.black
        view.delegate = self
        return view
    }()
    
    lazy var jobNotesTextField: UITextView! = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Job Notes"
        view.isEditable = true
        view.backgroundColor = UIColor.white
        view.textColor = UIColor.lightGray
        view.delegate = self
        view.tag = notesTag
        return view
    }()
    
    //todo person assigned to
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = Color.clouds
    }
    
    override func viewDidLoad() {
        //add the tap recongizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endKeyboardEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        // adjust the navigation Bar
        let rightBarItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(savePressed(sender:)))
        
        self.navigationItem.title = "Create Job"
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        view.addSubview(jobNameTextField)
        view.addSubview(jobDueDateTextField)
        view.addSubview(jobNotesTextField)
        
        setConstraints()
    }
    
    @objc func endKeyboardEditing(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 101 {
            textField.inputView = dueDateField
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == nameTag {
            jobDueDateTextField.becomeFirstResponder()
        } else if textField.tag == dueDateTag {
            jobNameTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
        textView.textColor = UIColor.black
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Job Notes"
            textView.textColor = UIColor.lightGray
        }
    }
    
    // MARK: Constraints
    
    private func setConstraints(){
        
        //job name
        NSLayoutConstraint(
            item: jobNameTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 0.15,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: jobNameTextField,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: jobNameTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: jobNameTextField,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: 35).isActive = true
        
        //date picker
        NSLayoutConstraint(
            item: jobDueDateTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: jobNameTextField,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 30).isActive = true
        
        NSLayoutConstraint(
            item: jobDueDateTextField,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: jobDueDateTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true

        NSLayoutConstraint(
            item: jobDueDateTextField,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: 35).isActive = true
        
        //job notes
        NSLayoutConstraint(
            item: jobNotesTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: jobDueDateTextField,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 30).isActive = true
        
        NSLayoutConstraint(
            item: jobNotesTextField,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: jobNotesTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: jobNotesTextField,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: 70).isActive = true
    }
    
    // MARK: Date Picker target
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        jobDueDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    
    // MARK: Nav bar button actions
    
    @IBAction func savePressed(sender: UIBarButtonItem){
    
        if !(jobNameTextField.text?.isEmpty)! && !(jobDueDateTextField.text?.isEmpty)! {
            var jobNotes: String?
            
            if jobNotesTextField.text! == "Job Notes" {
                jobNotes = nil
            } else {
                jobNotes = jobNotesTextField.text!
            }
            
            jobsViewModel?.addJob(withName: jobNameTextField.text!, withDueDate: dueDateField.date, withNotes: jobNotes, assignedTo: nil)
            
            self.navigationController?.popViewController(animated: true)
        }else{
            let alert = UIAlertController(title: "Invalid Job", message: "Please make sure all required fields are completed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
