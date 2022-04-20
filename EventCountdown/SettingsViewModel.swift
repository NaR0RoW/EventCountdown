import UIKit

final class SettingsViewModel {
    let title: String = "Settings"
    
    var coordinator: SettingsCoordinator?
    
    private let settingsModelData: [SettingsModel] = [
        SettingsModel(image: UIImage(systemName: "gearshape")!, name: "Preferences"),
        SettingsModel(image: UIImage(systemName: "moon.fill")!, name: "Night mode"),
        SettingsModel(image: UIImage(systemName: "questionmark.circle")!, name: "Support"),
        SettingsModel(image: UIImage(systemName: "message")!, name: "Suggestions"),
        SettingsModel(image: UIImage(systemName: "exclamationmark.circle")!, name: "About"),
        SettingsModel(image: UIImage(systemName: "star")!, name: "Rate app"),
        SettingsModel(image: UIImage(systemName: "square.and.arrow.up")!, name: "Share Days")
    ]
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        return settingsModelData.count
    }
    
    func cell(at indexPath: IndexPath) -> SettingsModel {
        return settingsModelData[indexPath.row]
    }
}
