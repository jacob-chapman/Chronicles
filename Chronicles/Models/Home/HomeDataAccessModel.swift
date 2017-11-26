//
//  Home.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/10/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import CoreData

class HomeDataAccessModel : DataAccessModelBase<Home> {

    // MARK: - add new home from Core Data
    public func addHome(withName name: String, withAddress address: String, withCity city: String, withZipcode zip: Int32, withState state: String) {
        let newHome = Home(context: managedObjectContext)
        
        newHome.address = address
        newHome.name = name
        newHome.zipcode = zip
        newHome.state = state
        newHome.city = city
        
        insertElement(withElement: newHome)
    }
    
}
