import UIKit

protocol TableViewDataSourceProtocol: UITableViewDelegate, UITableViewDataSource {
    var sections: [TableViewSectionBuilderProtocol] { get set }
}
