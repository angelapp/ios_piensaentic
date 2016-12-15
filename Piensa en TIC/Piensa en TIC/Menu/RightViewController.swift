import UIKit

struct RightViewConstants{
    static let TableCellIdentifier = "optionsCell"
}

class RightViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var settingsTable:UITableView!
    var items:[Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = ["About me"]
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
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView .dequeueReusableCell(withIdentifier: RightViewConstants.TableCellIdentifier) else { return UITableViewCell.init()}
        cell.textLabel?.text = (self.items[indexPath.row] as! String)
        return cell
    }
    
    //MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
