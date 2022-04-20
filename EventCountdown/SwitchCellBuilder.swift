import UIKit

final class SwitchCellBuilder: TableViewCellBuilderProtocol {
//    private let cocktail: CocktailObject
//    
//    init(cocktail: CocktailObject) {
//        self.cocktail = cocktail
//    }
    
    func registerCell(in tableView: UITableView) {
        tableView.registerCell(SwitchCell.self)
    }
 
    func cellAt(indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SwitchCell
        cell.configureCell()
//        cell.backgroundColor = .systemBackground
        
        return cell
    }
}
