import UIKit

class AdviceViewController: GeneralViewController {
    
    @IBOutlet var topImage: UIImageView!
    @IBOutlet var adviceNumber:UIImageView!
    @IBOutlet var adviceDescription:UILabel!
    @IBOutlet var adviceImage:UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup() {
        guard let topImageName = self.info["top_image_name"] else { return}
        guard let adviceNumberImage = self.info["adviceNumber"] else { return}
        guard let adviceDescriptionText = self.info["adviceDescription"] else {return}
        guard let adviceImageName = self.info["adviceImage"] else {return}
        
        let color = UIColor(hexString:colorText)
        topImage.image = UIImage(named:topImageName)
        adviceNumber.image = UIImage(named: adviceNumberImage)
        adviceDescription.textColor = color
        adviceDescription.text = adviceDescriptionText
        adviceImage.image = UIImage(named:adviceImageName)
    }
    

}
