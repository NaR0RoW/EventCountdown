import UIKit

final class TimeRemainingViewModel {
    enum Mode {
        case cell
        case detail
    }
    
    let timerRemainingParts: [String]
    private let mode: Mode
    
    var fontSize: CGFloat {
        switch mode {
        case .cell:
            return 25.0
        case .detail:
            return 60.0
        }
    }
    
    var alignment: UIStackView.Alignment {
        switch mode {
        case .cell:
            return .trailing
        case .detail:
            return .center
        }
    }
    
    init(timerRemainingParts: [String], mode: Mode) {
        self.timerRemainingParts = timerRemainingParts
        self.mode = mode
    }
}
