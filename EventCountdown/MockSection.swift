import UIKit

class MockSection: TableViewSectionBuilderProtocol {
    var builders: [TableViewCellBuilderProtocol]
    
    init(builders: [TableViewCellBuilderProtocol], tableView: UITableView) {
        self.builders = builders
        for builder in builders {
            builder.registerCell(in: tableView)
        }
    }
    
    func viewForHeader() -> UIView? {
        return nil
    }
    
    func heightForHeader() -> CGFloat {
        return 0.0
    }
    
    func viewForFooter() -> UIView? {
        return nil
    }
    
    func heightForFooter() -> CGFloat {
        return 0.0
    }
}
