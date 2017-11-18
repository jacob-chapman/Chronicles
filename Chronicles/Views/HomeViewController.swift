//
//  ViewController.swift
//  Chronicles
//
//  Created by Jacob Chapman on 10/23/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, DismissalDelegate {
    
    var homeViewModel = HomeViewModel()
    
    var disposeBag = DisposeBag()
    
    //MARK: UI Components
    lazy var addHomeButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Add Home", for: .normal)
        view.backgroundColor = Color.primaryColor
        view.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
        return view
    }()
    
    lazy var label: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Hello World"
        view.textAlignment = .center
        return view
    }()
    
    lazy var dismissButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(#imageLiteral(resourceName: "ic_clear"), for: .normal)
        view.addTarget(self, action: #selector(dismissClicked), for: .touchDown)
        return view
    }()
    
    
    var isFromTable: Bool = false
    
    init(fromTable isTable: Bool) {
        super.init(nibName: nil, bundle: nil)
        isFromTable = isTable
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let observableHomes = homeViewModel.fetchHome().asObservable()
        
        observableHomes.subscribe(onNext: {(homes) in
            let firstHome = homes.first
            
            if firstHome == nil {
                self.setupNoHome()
            }else{
                self.setupHome(withHome: firstHome!)
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)

        if isFromTable {
            view.addSubview(dismissButton)
            dismissButtonConstraints()
        }
        
    }

    //MARK: Button Method
    @IBAction func buttonClicked(sender:UIButton!){
        let vc = HomeInputViewController()
        vc.homeViewModel = homeViewModel
        vc.dismissalDelegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func dismissClicked(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: UI Constraint Functions
    
    func dismissButtonConstraints(){
        
        //Right Corner
        NSLayoutConstraint(
            item: dismissButton,
            attribute: .right,
            relatedBy: .equal,
            toItem: view,
            attribute: .right,
            multiplier: 1.0,
            constant: -5.0).isActive = true
        
        //Top
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            dismissButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 5).isActive = true
        } else {
            dismissButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 5).isActive = true
        }
    }
    
    //TODO reset view after adding or removing home
    //TODO maybe move cancel button on form to top corner to mimic iOS best practices
    
    func setupNoHome(){
        view.addSubview(addHomeButton)
        addHomeButtonConstraints()
    }
    
    func setupHome(withHome home: Home){
        view.addSubview(label)
        labelConstraints()
        
        label.text = home.name!
    }
    
    func addHomeButtonConstraints(){
        
        NSLayoutConstraint(
            item: addHomeButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: addHomeButton,
           attribute: .width,
           relatedBy: .equal,
           toItem: view,
           attribute: .width,
           multiplier: 0.75,
           constant: 0).isActive = true
        
        NSLayoutConstraint(
            item: addHomeButton,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0).isActive = true
    }
    
    func labelConstraints(){
        //Center textfield
        NSLayoutConstraint(
            item: label,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0).isActive = true
        
        //Set width of the text field
        NSLayoutConstraint(
            item: label,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.8,
            constant: 0.0).isActive = true
        
        NSLayoutConstraint(
            item: label,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0).isActive = true
    }
}

