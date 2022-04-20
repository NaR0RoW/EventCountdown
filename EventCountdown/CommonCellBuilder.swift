import UIKit

final class CommonCellBuilder: TableViewCellBuilderProtocol {
//    private let cocktail: CocktailObject
//    private let cellType: CellType
    
//    init(cocktail: CocktailObject, cellType: CellType) {
//        self.cocktail = cocktail
//        self.cellType = cellType
//    }
    
    func registerCell(in tableView: UITableView) {
        tableView.registerCell(CommonCell.self)
    }
    
    func cellAt(indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CommonCell
        cell.configureCell()
//        cell.backgroundColor = .systemBackground
        
        return cell
    }
}
