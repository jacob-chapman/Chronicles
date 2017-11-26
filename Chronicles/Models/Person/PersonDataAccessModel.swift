//
//  PersonDataAccessModel.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/22/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class PersonDataAccessModel : DataAccessModelBase<Person> {
    
    // MARK: - add new home from Core Data
    public func addPerson(withBirthDate bDay: Date, withFirstName fName: String, withLastName lName: String, withRole role: Int) {
        let newPerson = Person(context: managedObjectContext)
        
        newPerson.firstName = fName
        newPerson.lastName = lName
        newPerson.birthDate = bDay
        newPerson.role = Int16(role)
        
        insertElement(withElement: newPerson)
    }
    
    
    public func removePerson(withIndex index: Int){
        removeElement(withIndex: index)
    }
}
