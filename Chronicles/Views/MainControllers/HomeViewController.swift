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
    
    lazy var homeDashboardView: HomeDashboardView! = {
        let view = HomeDashboardView(frame: CGRect(x: 0, y: 0, width: (self.view?.frame.width)!, height: 340))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Color.backgroundColor
        
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
    }

    //MARK: Button Method
    @IBAction func buttonClicked(sender:UIButton!){
        let vc = HomeInputViewController()
        vc.homeViewModel = homeViewModel
        vc.dismissalDelegate = self
        vc.hidesBottomBarWhenPushed = true
//        self.navigationController?.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //TODO reset view after adding or removing home
    //TODO maybe move cancel button on form to top corner to mimic iOS best practices
    
    func setupNoHome(){
        view.addSubview(addHomeButton)
        addHomeButtonConstraints()
    }
    
    func setupHome(withHome home: Home){
        view.addSubview(homeDashboardView)
        
        if  addHomeButton.isDescendant(of: self.view) {
            addHomeButton.removeFromSuperview()
        }

//        homeDashboardConstraints()
        homeDashboardView.homeModel = home
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
    
    func homeDashboardConstraints(){
        //Center textfield
        NSLayoutConstraint(
            item: homeDashboardView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0).isActive = true
        
        //Set width of the text field
        NSLayoutConstraint(
            item: homeDashboardView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.8,
            constant: 0.0).isActive = true
        
        NSLayoutConstraint(
            item: homeDashboardView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 0.9,
            constant: 0.0).isActive = true
    }
}

