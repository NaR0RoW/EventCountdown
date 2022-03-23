import UIKit

struct EventCellViewModel {
    let date = Date()
    private static let imageCache = NSCache<NSString, UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    
    private var cacheKey: String {
        event.objectID.description
    }
    
    var timeRemainingStrings: [String] {
        guard let eventDate = event.date else { return [] }
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
    }
    
    var dayText: String {
        "2 days"
    }
    
    var dateText: String? {
        guard let eventDate = event.date else { return nil}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        return dateFormatter.string(from: eventDate)
    }
    
    var eventName: String? {
        event.name
    }
    
    private let event: Event
    
    init(_ event: Event) {
        self.event = event
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                guard let imageData = self.event.image, let image = UIImage(data: imageData) else { completion(nil)
                    return
                }
                Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
}
