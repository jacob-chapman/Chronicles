//
//  JobTableCell.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/19/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import UIKit

class JobTableCell : UITableViewCell {
    
    var jobNameLabel = UILabel()
    var jobNotesLabel = UILabel()
    var isCompletedSwitch = UISwitch()
    
    var switchValueChanged: (() -> Void)?
    
    var jobModel: Job? {
        didSet {
            bind()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        jobNameLabel = UILabel()
        jobNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        jobNameLabel.translatesAutoresizingMaskIntoConstraints = false
    
        jobNotesLabel.font = UIFont.preferredFont(forTextStyle: .body)
        jobNotesLabel.translatesAutoresizingMaskIntoConstraints = false
        jobNotesLabel.textColor = .lightGray
        jobNotesLabel.lineBreakMode = .byWordWrapping
        jobNotesLabel.numberOfLines = 0
        jobNotesLabel.adjustsFontSizeToFitWidth = false
        
        isCompletedSwitch.translatesAutoresizingMaskIntoConstraints = false
        isCompletedSwitch.isOn = false
        isCompletedSwitch.addTarget(self, action: #selector(isCompletedSwitchValueChanged(sender:)), for: .allTouchEvents)
        
        contentView.addSubview(jobNameLabel)
        contentView.addSubview(jobNotesLabel)
        contentView.addSubview(isCompletedSwitch)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint(item: jobNameLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 15).isActive = true
        
        NSLayoutConstraint(item: jobNameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 15).isActive = true
        
        NSLayoutConstraint(item: jobNameLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 35).isActive = true
        
        NSLayoutConstraint(item: jobNotesLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 15)
            .isActive = true
        
        NSLayoutConstraint(item: jobNotesLabel, attribute: .top, relatedBy: .equal, toItem: jobNameLabel, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true

        NSLayoutConstraint(item: jobNotesLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -15)
            .isActive = true
        
//        NSLayoutConstraint(item: jobNotesLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 25).isActive = true
//
        NSLayoutConstraint(item: jobNotesLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
            .isActive = true
        
        NSLayoutConstraint(item: isCompletedSwitch, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 0.85 , constant: 0).isActive = true
        
        NSLayoutConstraint(item: isCompletedSwitch, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0 , constant: 15).isActive = true
    }
    
    @objc func isCompletedSwitchValueChanged(sender: UISwitch){
        
        if switchValueChanged != nil {
            switchValueChanged!()
        }
    }
    
    private func bind(){
        jobNameLabel.text = jobModel?.name
        
        if jobModel?.notes != nil && !((jobModel?.notes?.isEmpty)!) {
            jobNotesLabel.text = jobModel?.notes
        }
        
        if (jobModel?.completed)! {
            isCompletedSwitch.isOn = true
        } else {
            isCompletedSwitch.isOn = false
        }
    }
}
