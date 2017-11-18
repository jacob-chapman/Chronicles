//
//  JobsDataModelExtensions.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/14/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import CoreData

extension Job {
    @nonobjc public class func jobsFetchRequest() -> NSFetchRequest<Job> {
        return NSFetchRequest<Job>(entityName: "Job");
    }
    
}
