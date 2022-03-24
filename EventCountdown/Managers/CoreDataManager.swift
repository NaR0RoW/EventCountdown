import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventsApp")
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        
        return persistentContainer
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            
            return try managedObjectContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
            
            return []
        }
    }
    
    func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            return try managedObjectContext.existingObject(with: id) as? T
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func save() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
