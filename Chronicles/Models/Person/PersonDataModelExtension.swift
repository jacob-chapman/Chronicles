//
//  PersonDataModelExtension.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/25/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import CoreData

extension Person {
    @nonobjc public class func personFetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person");
    }
    
}
