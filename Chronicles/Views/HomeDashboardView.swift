//
//  HomeDashboardView.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/20/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import UIKit


class HomeDashboardView : UIView {

    var homeModel: Home? {
        didSet {
            modelSet()
        }
    }

    var didSetConstraints = false
    
    lazy var homeNameLabel: UILabel! = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 24)
        view.textAlignment = .center
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var homeAddressLabel: UILabel! = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .callout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupDashboard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupDashboard()
    }
    
    private func setupDashboard(){
        self.addSubview(homeNameLabel)
        self.addSubview(homeAddressLabel)
        self.backgroundColor = .white
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if !didSetConstraints {
            didSetConstraints = true
            setConstraints()
            homeNameLabelConstraints()
            homeAddressLabelConstraints()
        }
    }
    
    override func didMoveToSuperview() {
        self.setNeedsUpdateConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview!, attribute: .bottom, multiplier: 0.15, constant: 0)
            .isActive = true
        
        NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: superview!, attribute: .left, multiplier: 1, constant: 0)
            .isActive = true
        
        NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: superview!, attribute: .width, multiplier: 1.0, constant: 0)
            .isActive = true
        
        NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 0, constant: 200).isActive = true
    }
    
    private func homeNameLabelConstraints() {
        NSLayoutConstraint(item: homeNameLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10)
            .isActive = true
        
        NSLayoutConstraint(item: homeNameLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 5)
            .isActive = true
        
        NSLayoutConstraint(item: homeNameLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -5)
            .isActive = true
        
        NSLayoutConstraint(item: homeNameLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
            .isActive = true
    }
    
    private func homeAddressLabelConstraints() {
        NSLayoutConstraint(item: homeAddressLabel, attribute: .top, relatedBy: .equal, toItem: homeNameLabel, attribute: .bottom, multiplier: 1.0, constant: 10)
            .isActive = true
        
        NSLayoutConstraint(item: homeAddressLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 5)
            .isActive = true
        
        NSLayoutConstraint(item: homeAddressLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -5)
            .isActive = true
        
        NSLayoutConstraint(item: homeAddressLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
            .isActive = true
    }
    
    private func modelSet(){
        
        homeNameLabel.text = homeModel?.name
        let street = (homeModel?.address)! + "\n"
        var cityStateZip = (homeModel?.city)! + ", "
        cityStateZip += (homeModel?.state)! + " " + String(describing: (homeModel?.zipcode)!)
        homeAddressLabel.text = street + cityStateZip
    }
}
