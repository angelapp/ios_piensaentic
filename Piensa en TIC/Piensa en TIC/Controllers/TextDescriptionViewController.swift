import UIKit

class TextDescriptionViewController: GeneralViewController {

    @IBOutlet var topImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var exampleLabel: UILabel!
    @IBOutlet var topImageConstraint: NSLayoutConstraint!
    
    
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
        guard let imageName = self.info["image"] else {return}
        guard let example = self.info["example"] else {return}
        
        if topImageName == "" {
            topImageConstraint.constant = 20.0
        }
        
        topImage.image = UIImage(named:topImageName)
        descriptionLabel.text = String(format: descriptionText)
        descriptionLabel.textColor = UIColor.init(hexString: colorText)
        image.image = UIImage(named:imageName)
        if example.contains("|") {
            exampleLabel.attributedText = processExample(example)
        } else {
            exampleLabel.text = example
        }
        
        exampleLabel.textColor = UIColor.init(hexString: colorText)
    }
}
