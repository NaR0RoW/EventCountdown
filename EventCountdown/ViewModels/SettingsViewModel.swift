import Foundation

final class SettingsViewModel {
    let title = "Settings"
    
    var coordinator: SettingsCoordinator?
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
}
