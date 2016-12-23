import UIKit

class KnownFriendsViewController: GeneralViewController {

    @IBOutlet var topDescription:UILabel!
    @IBOutlet var nameField1:UITextField!
    @IBOutlet var nickNameField1:UITextField!
    @IBOutlet var nameField2:UITextField!
    @IBOutlet var nickNameField2:UITextField!
    
    @IBOutlet var box1:UIView!
    @IBOutlet var box2:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
