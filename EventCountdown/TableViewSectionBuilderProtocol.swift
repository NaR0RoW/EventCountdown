import UIKit

protocol TableViewSectionBuilderProtocol {
    var builders: [TableViewCellBuilderProtocol] { get }
    func viewForHeader() -> UIView?
    func heightForHeader() -> CGFloat
    func viewForFooter() -> UIView?
    func heightForFooter() -> CGFloat
    func numberOfRows() -> Int
    func cellAt(indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
}

extension TableViewSectionBuilderProtocol {
    func numberOfRows() -> Int {
        return builders.count
    }
    
    func cellAt(indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        return builders[indexPath.row].cellAt(indexPath: indexPath, in: tableView)
    }
}
