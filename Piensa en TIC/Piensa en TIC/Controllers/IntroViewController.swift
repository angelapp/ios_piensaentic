import UIKit

class IntroViewController: GeneralViewController {

    @IBOutlet var topImage: UIImageView!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup(){
        guard let topImageName = self.info["top_image_name"] else { return}
        guard let descriptionText = self.info["description"] else { return}
        
        topImage.image = UIImage(named:topImageName)
        descriptionLabel.textColor = UIColor(hexString: self.colorText)
        descriptionLabel.text = descriptionText

        if let secondaryImageName = self.info["secondary_image"] {
            backgroundImage.image = UIImage(named: secondaryImageName)
        }
    }

}
