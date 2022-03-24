import UIKit

final class EventDetailViewController: UIViewController {
    var eventDetailViewModel: EventDetailViewModel!
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var timeRemainingStackView: TimeRemainingStackView = TimeRemainingStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        timeRemainingStackView.setup()
        
        eventDetailViewModel.onUpdate = { [weak self] in
            guard let self = self,
                  let timeRemainingViewModel = self.eventDetailViewModel.timeRemainingViewModel
            else { return }
            self.backgroundImageView.image = self.eventDetailViewModel.image
            self.timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        
        eventDetailViewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        eventDetailViewModel.viewDidDisappear()
    }
}

extension EventDetailViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: eventDetailViewModel, action: #selector(eventDetailViewModel.editButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .lightPurple
        navigationController?.navigationBar.tintColor = .lightPurple
        
        configureBackgroundImageView()
        configureTimeRemainingStackView()
    }
    
    private func configureBackgroundImageView() {
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func configureTimeRemainingStackView() {
        view.addSubview(timeRemainingStackView)
        NSLayoutConstraint.activate([
            timeRemainingStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeRemainingStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
