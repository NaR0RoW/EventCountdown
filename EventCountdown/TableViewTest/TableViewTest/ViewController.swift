import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .red
    }
}

// ---------------------------------------------------------------------------------------------------------------------------
class PhotoTableViewCell: UITableViewCell { }
class VideoTableViewCell: UITableViewCell { }
class TextOnlyTableViewCell: UITableViewCell { }

protocol ListItem {
    var isPhotoItem: Bool {get}
    var isVideoItem: Bool {get}
    var isTextItem: Bool {get}
}

class MyVerboseViewController: UITableViewController {
    
    var items = [ListItem]()
    
    let photoCellIdentifier = String(describing: type(of: PhotoTableViewCell.self))
    let videoCellIdentifier = String(describing: type(of: VideoTableViewCell.self))
    let textCellIdentifier = String(describing: type(of: TextOnlyTableViewCell.self))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: photoCellIdentifier, bundle: Bundle(for: PhotoTableViewCell.self)), forCellReuseIdentifier: photoCellIdentifier)
        tableView.register(UINib(nibName: videoCellIdentifier, bundle: Bundle(for: VideoTableViewCell.self)), forCellReuseIdentifier: videoCellIdentifier)
        tableView.register(UINib(nibName: textCellIdentifier, bundle: Bundle(for: TextOnlyTableViewCell.self)), forCellReuseIdentifier: textCellIdentifier)
    }
    
    //...
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell: UITableViewCell
        
        if item.isPhotoItem {
            cell = tableView.dequeueReusableCell(withIdentifier: photoCellIdentifier, for: indexPath)
            // Configure photo cell...
            
        } else if item.isVideoItem {
            cell = tableView.dequeueReusableCell(withIdentifier: videoCellIdentifier, for: indexPath)
            // Configure video cell...
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
            // Configure text cell...
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        if item.isPhotoItem {
            // Do something for photo...
            
        } else if item.isVideoItem {
            // Do something for video...
            
        } else {
            // Do something for text...
            
        }
    }
    
}

// ---------------------------------------------------------------------------------------------------------------------------

protocol TableCellController {
    static func registerCell(on tableView: UITableView)
    func cellFromTableView(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell
    func didSelectCell()
}

protocol CollectionCellController {
    static func registerCell(on collectionView: UICollectionView)
    func cellFromCollectionView(_ collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> UICollectionViewCell
    func didSelectCell()
}

class PhotoTableCellController: TableCellController {
    
    fileprivate let item: ListItem
    
    init(item: ListItem) {
        self.item = item
    }
    
    fileprivate static var cellIdentifier: String {
        return String(describing: type(of: PhotoTableViewCell.self))
    }
    
    static func registerCell(on tableView: UITableView) {
        tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle(for: PhotoTableViewCell.self)), forCellReuseIdentifier: cellIdentifier)
    }
    
    func cellFromTableView(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellIdentifier, for: indexPath) as! PhotoTableViewCell
        
        // Configure photo cell...
        
        return cell
    }
    
    func didSelectCell() {
        // Do something for photo...
    }
    
}
