import UIKit.UIViewController

// To hide UINavigationBar gray bottom line
extension UIViewController {
    func hideNavigationBarGrayBottomLine() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemBackground
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    }
}
