//
//  DatabaseHandler.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 31/8/21.
//

import UIKit
import CoreData

class DatabaseHandler {
    
    private let viewContext: NSManagedObjectContext
    static let shared = DatabaseHandler()
    
    private init() {
        viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func add<T: NSManagedObject>(type: T.Type) -> T? {
        
        guard let entityName = T.entity().name else {return nil}
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else {return nil}
        let object = T(entity: entity, insertInto: viewContext)
        
        return object
    }
    
    func fetch<T: NSManagedObject>(type: T.Type) -> [T] {
        let request = T.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
            return result as! [T]
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func delete<T: NSManagedObject>(object: T) { 
        viewContext.delete(object)
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
}
