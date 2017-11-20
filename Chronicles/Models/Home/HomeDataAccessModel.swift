//
//  Home.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/10/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class HomeDataAccessModel {

    private var homeFromCoreData = Variable<[Home]>([])// = Variable<Home>(Home)
    private var managedObjectContext: NSManagedObjectContext
    
    
    init(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
    
        homeFromCoreData.value = [Home]()
        managedObjectContext = delegate.persistentContainer.viewContext
        
        homeFromCoreData.value = fetchHome()
    }
    
    //MARK -- fething home model from Core Data
    private func fetchHome() -> [Home] {
        let homeFetchRequest = Home.homeFetchRequest()
     
        homeFetchRequest.returnsObjectsAsFaults = false
        
        do{
            let homes = try managedObjectContext.fetch(homeFetchRequest)
            
            //we should not have more than one home currently -- possibly could change at a later date
            //assert(homes.count < 2)
            
            if let home = homes.first {
                //we have a home cached return
                return [home]
            }
            else {
                return []
            }
        } catch {
            return []
        }
    }

    // MARK: - return observable home
    public func fetchObservableData() -> Observable<[Home]> {
            homeFromCoreData.value = fetchHome()
            return homeFromCoreData.asObservable()
    }
    
    // MARK: - add new home from Core Data
    public func addHome(withName name: String, withAddress address: String, withCity city: String, withZipcode zip: Int32, withState state: String) {
        let newHome = Home(context: managedObjectContext)
        
        newHome.address = address
        newHome.name = name
        newHome.zipcode = zip
        newHome.state = state
        newHome.city = city
        
        do {
            try managedObjectContext.save()
            homeFromCoreData.value = fetchHome()
        } catch {
            fatalError("error saving home data")
        }
    }

//leaving the below in for notes and quick looks
    
    
//    // MARK: - toggle selected todo's isCompleted value
//    public func toggleTodoIsCompleted(withIndex index: Int) {
//        todosFromCoreData.value[index].isCompleted = !todosFromCoreData.value[index].isCompleted
//
//        do {
//            try managedObjectContext.save()
//            todosFromCoreData.value = fetchData()
//        } catch {
//            fatalError("error change data")
//        }
//
//    }
//
//    // MARK: - remove specified todo from Core Data
//    public func removeTodo(withIndex index: Int) {
//        managedObjectContext.delete(todosFromCoreData.value[index])
//
//        do {
//            try managedObjectContext.save()
//            todosFromCoreData.value = fetchData()
//        } catch {
//            fatalError("error delete data")
//        }
//    }
    
}
