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

class JobDataAccessModel {
    
    private var jobsFromCoreData = Variable<[Job]>([])
    private var managedObjectContext: NSManagedObjectContext
    
    init(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
    
        jobsFromCoreData.value = [Job]()
        managedObjectContext = delegate.persistentContainer.viewContext
        
        jobsFromCoreData.value = fetchJobs()
    }
    
    private func fetchJobs() -> [Job]{
        let jobsFetchRequest = Job.jobsFetchRequest()
        
        jobsFetchRequest.returnsObjectsAsFaults = false
        
        do {
            return try managedObjectContext.fetch(jobsFetchRequest)
        } catch {
            return []
        }
    }
    
    // MARK: return observable jobs
    public func fetchObservableData() -> Observable<[Job]> {
        jobsFromCoreData.value = fetchJobs()
        return jobsFromCoreData.asObservable()
    }
    
    public func addJob(withName name: String, withDueDate dueDate: Date, withNotes notes: String, assignedTo person: Person){
        
        let newJob = Job(context: managedObjectContext)
        
        newJob.dueDate = dueDate
        newJob.name = name
        newJob.notes = notes
        newJob.assignedTo = person
        
        do {
            try managedObjectContext.save()
            jobsFromCoreData.value = fetchJobs()
        } catch {
            fatalError("error saving jobs data")
        }
    }
    
    // MARK: toggle jobs completed flag
    
    public func toggleJobIsComplete(withIndex index: Int){
        jobsFromCoreData.value[index].completed = !jobsFromCoreData.value[index].completed
        
        do{
            try managedObjectContext.save()
            jobsFromCoreData.value = fetchJobs()
        } catch {
            fatalError("error toggling job complete")
        }
    }
    
    public func removeJob(withIndex index: Int){
        managedObjectContext.delete(jobsFromCoreData.value[index])
        
        do {
            try managedObjectContext.save()
            jobsFromCoreData.value = fetchJobs()
        } catch {
            fatalError("error deleting jobs")
        }
    }
}
