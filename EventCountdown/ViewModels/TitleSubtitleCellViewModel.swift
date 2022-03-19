import UIKit

final class TitleSubtitleCellViewModel {
    let title: String
    private(set) var subtitle: String
    let placeholder: String
    let type: CellType
    private(set) var onCellUpdate: (() -> Void)?
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter
    }()
    private(set) var image: UIImage?
    
    enum CellType {
        case text
        case date
        case image
    }
    
    init(title: String, subtitle: String, placeholder: String, type: CellType, onCellUpdate: (() -> Void)?) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    
    func update(subtitle: String) {
        self.subtitle = subtitle
    }
    
    func update(_ date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subtitle = dateString
        onCellUpdate?()
    }
    
    func update(_ image: UIImage) {
        self.image = image
        onCellUpdate?()
    }
}
