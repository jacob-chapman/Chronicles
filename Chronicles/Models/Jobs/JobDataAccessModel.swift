//
//  TodoDataAccessModel.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/14/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class JobDataAccessModel : DataAccessModelBase<Job> {
    
    public func addJob(withName name: String, withDueDate dueDate: Date, withNotes notes: String?, assignedTo person: Person?){
        
        let newJob = Job(context: managedObjectContext)
        
        newJob.dueDate = dueDate
        newJob.name = name
        newJob.notes = notes
        
        if person != nil {
            newJob.assignedTo = person
        }
        
        insertElement(withElement: newJob)
    }
    
    // MARK: toggle jobs completed flag
    
    public func toggleJobIsComplete(withIndex index: Int){
        elementsFromCoreData.value[index].completed = !elementsFromCoreData.value[index].completed
        
        do{
            try managedObjectContext.save()
            updateData()
        } catch {
            fatalError("error toggling job complete")
        }
    }
    
    public func removeJob(withIndex index: Int){
        removeElement(withIndex: index)
    }
}
