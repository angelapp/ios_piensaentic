import UIKit

class GeneralViewController: UIViewController {
    
    var index:Int!
    var info:[String:String]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUserNameFromUserDefaults() -> String {
        let userDefaults = UserDefaults.standard
        guard let name:String = userDefaults.object(forKey: "userName") as! String? else {return ""}
     
        return name
    }
}
