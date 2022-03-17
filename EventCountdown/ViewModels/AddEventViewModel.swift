import Foundation

final class AddEventViewModel {
    var coordinator: AddEventCoordinator?
    private(set) var cells: [AddEventViewModel.AddEventCell] = []
    var onUpdate: () -> Void = { }
    let title = "Add"
    
    enum AddEventCell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> AddEventCell {
        return cells[indexPath.row]
    }
    
    func viewDidLoad() {
        cells = [
            .titleSubtitle(TitleSubtitleCellViewModel(
                title: "Name",
                subtitle: "",
                placeholder: "Add a name",
                type: .text,
                onCellUpdate: { }
            )),
            .titleSubtitle(TitleSubtitleCellViewModel(
                title: "Date",
                subtitle: "",
                placeholder: "Select date",
                type: .date,
                onCellUpdate: { [weak self] in
                    self?.onUpdate()
                }
            )),
            .titleSubtitle(TitleSubtitleCellViewModel(
                title: "Background",
                subtitle: "",
                placeholder: "",
                type: .image,
                onCellUpdate: { [weak self] in
                    self?.onUpdate()
                }
            ))
        ]
        onUpdate()
    }
    
    func tappedDone() {
        print("Tapped Done")
        // extract info from cell view models and save in core data
        // tell coordinator to dismiss
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle: subtitle)
        }
    }
}
