//
//  Home+CoreDataProperties.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/11/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import CoreData

extension Home {
    @nonobjc public class func homeFetchRequest() -> NSFetchRequest<Home> {
        return NSFetchRequest<Home>(entityName: "Home");
    }
    
}
