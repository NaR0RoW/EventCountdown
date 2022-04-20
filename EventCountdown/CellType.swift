import Foundation

enum CellType: CaseIterable {
    case date
    case startTime
    case endTime
    case repeatTime
    case eventFormat
    
    var description: String {
        switch self {
        case .date:
            return "Date"
        case .startTime:
            return "Start Time"
        case .endTime:
            return "End Time"
        case .repeatTime:
            return "Repeat"
        case .eventFormat:
            return "Event Format"
        }
    }
}
