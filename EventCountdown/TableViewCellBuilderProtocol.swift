import UIKit

protocol TableViewCellBuilderProtocol {
    func registerCell(in tableView: UITableView)
    func cellAt(indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
}
