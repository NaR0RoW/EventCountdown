import UIKit

final class DateCellBuilder: TableViewCellBuilderProtocol {
//    private let cocktail: CocktailObject
    
//    init(cocktail: CocktailObject) {
//        self.cocktail = cocktail
//    }
    
    func registerCell(in tableView: UITableView) {
        tableView.registerCell(DateCell.self)
    }
    
    func cellAt(indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DateCell
        cell.configureCell()
        
        return cell
    }
}
