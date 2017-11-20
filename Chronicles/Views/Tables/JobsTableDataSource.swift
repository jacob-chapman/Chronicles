//
//  JobsTableDataSource.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/19/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class JobsTableDataSource : NSObject, UITableViewDataSource {
    
    var jobs: [Job] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! JobTableCell
        
        let jobModel = jobs[indexPath.row]
        cell.jobModel = jobModel
    
        return cell
    }
}
