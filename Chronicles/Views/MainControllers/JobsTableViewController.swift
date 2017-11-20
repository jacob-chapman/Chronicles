//
//  HomeTableViewController.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/2/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class JobsTableViewController : UIViewController, UITableViewDelegate {
   
    var jobsViewModel = JobsViewModel()
    var disposeBag = DisposeBag()
    var myTableView: UITableView  =   UITableView()
    var jobsDataSource = JobsTableDataSource()
    
    let taskCellIdentifier = "taskCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        myTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        myTableView.rx.setDelegate(self)
        myTableView.dataSource = jobsDataSource
        myTableView.register(JobTableCell.self, forCellReuseIdentifier: taskCellIdentifier)
        
        self.view.addSubview(myTableView)
        
        let addBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(sender:)))
        self.navigationItem.rightBarButtonItem = addBarItem
        
        populateTableView()
    }
    
    func populateTableView(){
        let observableJobs = jobsViewModel.getJobs().asObservable()
        
//        observableJobs.bind(to: myTableView.rx.items(cellIdentifier: "taskCell", cellType: JobTableCell.self))
//        { (index, job, cell) in
//
//            cell.jobModel = job
//            cell.switchValueChanged = {
//                    self.jobsViewModel.toggleJobCompleted(withIndex: index)
//            }
//
//        }.disposed(by: disposeBag)

        observableJobs.subscribe(onNext: { jobs in
            self.jobsDataSource.jobs = jobs
            self.myTableView.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func addTapped(sender:UIBarButtonItem){
        print("bar button tapped")
        let vc =  JobDataEntryViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.jobsViewModel = jobsViewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        //todo assign option
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            self.jobsViewModel.removeJob(withIndex: index.row)
        }
        delete.backgroundColor = .red
        
        return [delete]
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
