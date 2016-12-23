import UIKit

class MessageViewController: GeneralViewController {

    @IBOutlet var descriptionImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup(){
        guard let headerDescription = self.info["headerDescription"] else { return}
        guard let descriptionImageName = self.info["descriptionImage"] else { return}
        
        descriptionImage.image = UIImage(named:descriptionImageName)
        descriptionLabel.text = String(format: headerDescription)
        descriptionLabel.textColor = UIColor.init(hexString: colorText)
    }
}
