import UIKit

class AdviceEncryptViewController: GeneralViewController {
    
    @IBOutlet var headerLabel:UILabel!
    @IBOutlet var numberImageOne:UIImageView!
    @IBOutlet var numberImageTwo:UIImageView!
    @IBOutlet var numberTextOne:UILabel!
    @IBOutlet var numberTextTwo:UILabel!
    @IBOutlet var imageOne:UIImageView!
    @IBOutlet var imageTwo:UIImageView!
    

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
        let color = UIColor(hexString:colorText)
        
        if let headerText = self.info["header"] {
            headerLabel.text = headerText
            headerLabel.textColor = color
        }
        
        if let adviceOne = self.info["adviceOne"] {
            numberTextOne.text = adviceOne
            numberTextOne.textColor = color
        }
        if let adviceTwo = self.info["adviceTwo"] {
            numberTextTwo.text = adviceTwo
            numberTextTwo.textColor = color
        }
        
        if let adviceNumberOne = self.info["imageAdviceOne"] {
            numberImageOne.image = UIImage(named:adviceNumberOne)
        }
        if let adviceImageTwo = self.info["imageAdviceTwo"] {
            numberImageTwo.image = UIImage(named:adviceImageTwo)
        }
        
        if let additionalImageOne = self.info["additionalImageOne"] {
            imageOne.image = UIImage(named:additionalImageOne)
        }
        if let additionalImageTwo = self.info["additionalImageTwo"] {
            imageTwo.image = UIImage(named:additionalImageTwo)
        }
    }
}
