import UIKit

final class AddEventTitleViewController: UIViewController {
    var addEventTitleViewModel: AddEventTitleViewModel!
    
    private let maxCharactersCounter: Int = 25
    
    private let symbolsCounterLabel: UILabel = {
        let label = UILabel()
        label.text = "0/25"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.becomeFirstResponder()
        textView.text = "Add Title"
        textView.textColor = .lightGray
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        textView.font = .systemFont(ofSize: 30.0)
        textView.autocorrectionType = .no
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureSymbolsCounterLabel()
        configureTitleTextField()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addEventTitleViewModel.viewDidDisappear()
    }
}

extension AddEventTitleViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = addEventTitleViewModel.title

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
        view.addSubview(titleTextView)
        titleTextView.delegate = self
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: symbolsCounterLabel.bottomAnchor, constant: 10.0),
            titleTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            titleTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            titleTextView.heightAnchor.constraint(equalToConstant: 300.0)
        ])
    }
    
    @objc private func tapDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tapNext() {
        addEventTitleViewModel.tappedStartAddDate()
    }
}

// FIXME: Fix text counter (It starts with 2/25)
extension AddEventTitleViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty {
            textView.text = "Add Title"
            textView.textColor = .lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        } else if textView.textColor == .lightGray && !text.isEmpty {
            textView.textColor = .black
            textView.text = text
        } else {
            return textView.text.count + (text.count - range.length) <= maxCharactersCounter
        }
        
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if view.window != nil {
            if textView.textColor == .lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        symbolsCounterLabel.text = "\(textView.text.count)/25"
    }
}
