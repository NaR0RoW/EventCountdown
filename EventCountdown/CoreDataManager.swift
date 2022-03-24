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
    
    func saveEvent(name: String, date: Date, image: UIImage) {
        let event = Event(context: managedObjectContext)
        event.setValue(name, forKey: "name")
        
        let resizedImage = image.sameAspectRatio(newHeight: 250.0)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        
        event.setValue(date, forKey: "date")
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func fetchEvent() -> [Event] {
        do {
            let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
            let events = try managedObjectContext.fetch(fetchRequest)
            
            return events
        } catch {
            print(error.localizedDescription)
            
            return []
        }
    }
    
    func getEvent(_ id: NSManagedObjectID) -> Event? {
        do {
            return try managedObjectContext.existingObject(with: id) as? Event
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func updateEvent(event: Event, name: String, date: Date, image: UIImage) {
        event.setValue(name, forKey: "name")
        
        let resizedImage = image.sameAspectRatio(newHeight: 250.0)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        
        event.setValue(date, forKey: "date")
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
