//
//  HomeInputViewController.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/12/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import UIKit

class HomeInputViewController : UIViewController, Dismissable, UITextFieldDelegate {
    
    var dismissalDelegate: DismissalDelegate?
    
    var homeViewModel: HomeViewModel?
    
    // MARK: UI Components
    lazy var nameTextField: UITextField! = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.textAlignment = .center
        view.placeholder = "Home Name"
        view.delegate = self
        return view
    }()

    lazy var addressTextField: UITextField! = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.textAlignment = .center
        view.placeholder = "Address"
        view.delegate = self
        return view
    }()
    
    lazy var cityTextField: UITextField! = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.textAlignment = .center
        view.placeholder = "City"
        view.delegate = self
        return view
    }()
    
    lazy var zipcodeTextField: UITextField! = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.textAlignment = .center
        view.placeholder = "Zipcode"
        view.keyboardType = .numberPad
        view.delegate = self
        return view
    }()
    
    lazy var stateTextField: UITextField! = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.textAlignment = .center
        view.placeholder = "State"
        view.delegate = self
        return view
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        //navigation bar
        let rightNavItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveHomePressed(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightNavItem
        self.navigationItem.title = "Create Home"
        
        self.view.backgroundColor = Color.clouds
        
        view.addSubview(nameTextField)
        view.addSubview(addressTextField)
        view.addSubview(cityTextField)
        view.addSubview(zipcodeTextField)
        view.addSubview(stateTextField)
        
        nameFieldConstraints()
        addressFieldConstraints()
        zipcodeFieldConstraints()
        stateFieldConstraints()
        cityFieldConstraints()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    // MARK: Save Home
    
    @IBAction func saveHomePressed(sender:UIButton){
        
        if  (nameTextField.text?.isEmpty)! || (cityTextField.text?.isEmpty)! || (addressTextField.text?.isEmpty)! || (zipcodeTextField.text?.isEmpty)! || (stateTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Invalid Home", message: "Please make sure all fields are filled out", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            homeViewModel!.addHome(withName: nameTextField.text!, withAddress: addressTextField.text!,withCity: cityTextField.text!, withZipcode: Int32(zipcodeTextField.text!)!, withState: stateTextField.text!)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    // MARK: UITextFieldDelegate functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    // MARK: Constraints
    func stateFieldConstraints() {
        
        NSLayoutConstraint(
            item: stateTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: stateTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: zipcodeTextField,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 25).isActive = true
        
        NSLayoutConstraint(
            item: stateTextField,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1,
            constant: 0).isActive = true
    }
    
    func cityFieldConstraints() {
        
        NSLayoutConstraint(
            item: cityTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: cityTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: addressTextField,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 25).isActive = true
        
        NSLayoutConstraint(
            item: cityTextField,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1,
            constant: 0).isActive = true
    }

    func zipcodeFieldConstraints() {
        
        NSLayoutConstraint(
            item: zipcodeTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: zipcodeTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: cityTextField,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 25).isActive = true
        
        NSLayoutConstraint(
            item: zipcodeTextField,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1,
            constant: 0).isActive = true
    }
    
    func addressFieldConstraints() {
        
        NSLayoutConstraint(
            item: addressTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: addressTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: nameTextField,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 25).isActive = true
        
        NSLayoutConstraint(
            item: addressTextField,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1,
            constant: 0).isActive = true
    }
    
    func nameFieldConstraints() {
        
        NSLayoutConstraint(
            item: nameTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: nameTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 0.1,
            constant: 15).isActive = true
        
        NSLayoutConstraint(
            item: nameTextField,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1,
            constant: 0).isActive = true
    }
}
