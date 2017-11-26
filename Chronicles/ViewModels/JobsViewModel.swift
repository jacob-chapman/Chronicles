//
//  JobsViewModel.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/18/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

struct JobsViewModel {
    
    private var jobs = Variable<[Job]>([])
    private var jobsDataAccessProvider = JobDataAccessModel(withEntityName: "Job")
    private var disposeBag = DisposeBag()
    
    init(){
        fetchJobsAndUpdateObservableJobs()
    }
    
    
    public func getJobs() -> Variable<[Job]> {
            return jobs
    }
    
    private func fetchJobsAndUpdateObservableJobs() {
        jobsDataAccessProvider.fetchObservableData()
            .map({ $0 })
            .subscribe(onNext: {  (jobs) in
                self.jobs.value = jobs
            })
            .disposed(by: disposeBag)
    }
    
    public func addJob(withName name: String, withDueDate dueDate: Date, withNotes notes: String?, assignedTo person: Person?){
        jobsDataAccessProvider.addJob(withName: name, withDueDate: dueDate, withNotes: notes, assignedTo: person)
    }
    
    public func toggleJobCompleted(withIndex index: Int){
        jobsDataAccessProvider.toggleJobIsComplete(withIndex: index)
    }
    
    public func removeJob(withIndex index: Int){
        jobsDataAccessProvider.removeJob(withIndex: index)
    }
}
