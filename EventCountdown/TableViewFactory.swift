import UIKit

final class TableViewFactory: FactoryProtocol {
//    private let model: CocktailObject
    private let tableView: UITableView
    
//    init(model: CocktailObject, tableView: UITableView) {
//        self.model = model
//        self.tableView = tableView
//    }
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func getSections() -> [TableViewSectionBuilderProtocol] {
        return [
//            MockSection(
//                builders: [DateCellBuilder()],
//                tableView: tableView
//            ),

            SimpleHeaderSection(
                title: CellType.date.description,
                builders: [DateCellBuilder()],
                tableView: tableView
            ),
            
            SimpleHeaderSection(
                title: CellType.startTime.description,
                builders: [DateCellBuilder()],
                tableView: tableView
            ),
            
            SimpleHeaderSection(
                title: CellType.endTime.description,
                builders: [DateCellBuilder()],
                tableView: tableView
            ),

            SimpleHeaderSection(
                title: CellType.repeatTime.description,
                builders: [CommonCellBuilder()],
                tableView: tableView
            ),

            SimpleHeaderSection(
                title: CellType.eventFormat.description,
                builders: [CommonCellBuilder()],
                tableView: tableView
            )
        ]
    }
}
