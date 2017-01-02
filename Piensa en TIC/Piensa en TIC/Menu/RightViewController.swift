import UIKit

struct RightViewConstants{
    static let TableCellIdentifier = "optionsCell"
}

class RightViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var settingsTable:UITableView!
    var delegate:SelectRightMenuItem!
    let mainConfigurator = MainConfigurator.sharedConfiguration
    var items:[Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = mainConfigurator.menuContent()
        self.settingsTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView .dequeueReusableCell(withIdentifier: RightViewConstants.TableCellIdentifier) else { return UITableViewCell.init()}
        let dic = self.items[indexPath.row] as! NSDictionary
        cell.textLabel?.text = dic["text"] as! String!
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = UIImage(named:dic["image"] as! String!)
        
        cell.drawBorder(UIColor.white, y: cell.frame.size.height, key: "BottomBorder", dotted: false)
        return cell
    }
    
    //MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = delegate else {return}
        let dic = self.items[indexPath.row] as! NSDictionary
        delegate.selectRightMenuItem(content: dic["content"] as! String!)
    }
    
}
