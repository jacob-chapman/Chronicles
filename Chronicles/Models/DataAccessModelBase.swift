//
//  DataAccessModelBase.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/26/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

protocol DataAccessModelProtocol {
    
    var entityName: String { get }
}

class DataAccessModelBase<Element>: DataAccessModelProtocol {
    
    internal var elementsFromCoreData = Variable<[Element]>([])
    internal var managedObjectContext: NSManagedObjectContext
    
    internal var entityName: String
    
    init(withEntityName name: String) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        elementsFromCoreData.value = [Element]()
        managedObjectContext = delegate.persistentContainer.viewContext
        entityName = name
    }
    
    internal func fetchRequest() -> [Element] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            return try managedObjectContext.fetch(fetchRequest) as! [Element]
        } catch {
            return []
        }
    }
    
    public func fetchObservableData() -> Observable<[Element]> {
        elementsFromCoreData.value = fetchRequest()
        return elementsFromCoreData.asObservable()
    }
    
    internal func insertElement(withElement newElement: Element){
        
        do{
            try managedObjectContext.save()
            elementsFromCoreData.value = fetchRequest()
        } catch {
            fatalError("error saving " + entityName)
        }
    }
    
    internal func removeElement(withIndex index: Int) {
        managedObjectContext.delete(elementsFromCoreData.value[index] as! NSManagedObject)
        
        do {
            try managedObjectContext.save()
            elementsFromCoreData.value = fetchRequest()
        } catch {
            fatalError("error deleting " + entityName)
        }
    }
    
    internal func updateData() {
        elementsFromCoreData.value = fetchRequest()
    }
    
}
