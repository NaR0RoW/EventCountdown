import UIKit

final class NewAddEventViewController: UIViewController {
    var newAddEventViewModel: NewAddEventViewModel!
    
    private let symbolsCounterLabel: UILabel = {
        let label = UILabel()
        label.text = "0/25"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy private var titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemTeal
        textField.becomeFirstResponder()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureSymbolsCounterLabel()
        configureTitleTextField()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        newAddEventViewModel.viewDidDisappear()
    }
}

extension NewAddEventViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = newAddEventViewModel.title

        hideNavigationBarGrayBottomLine()
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(tapDismiss))
        leftBarButtonItem.tintColor = .label
        
        let rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(tapNext))
        rightBarButtonItem.tintColor = .label
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func configureSymbolsCounterLabel() {
        view.addSubview(symbolsCounterLabel)
        NSLayoutConstraint.activate([
            symbolsCounterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200.0),
            symbolsCounterLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            symbolsCounterLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0)
        ])
    }
    
    private func configureTitleTextField() {
        view.addSubview(titleTextField)
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: symbolsCounterLabel.bottomAnchor, constant: 15.0),
            titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            titleTextField.heightAnchor.constraint(equalToConstant: 150.0)
        ])
    }
    
    @objc private func tapDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tapNext() {
        newAddEventViewModel.tappedStartAddDate()
    }
}
  
extension NewAddEventViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.utf16.count)! + string.utf16.count - range.length
        
        if newLength <= 25 {
            symbolsCounterLabel.text = "\((0) + newLength)/25"
        }
    
        return newLength <= 25
    }
}
