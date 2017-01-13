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
        if((descriptionText.range(of: "Ahora eres")) != nil){
            descriptionLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
            image.sizeToFit()
            //topImage.frame = CGRect(x : topImage.frame.origin.x + 30, y : topImage.frame.origin.y, width : 300,height : 80.0)
            //image.sizeThatFits(CGSize(width: 100, height : 100))
            //image.frame = CGRect(x : image.frame.origin.x, y : image.frame.origin.y, width : image.frame.width,height : 200.0)
        }
        
        image.image = UIImage(named:imageName)
        if example.contains("|") {
            exampleLabel.attributedText = processExample(example)
        } else {
            exampleLabel.text = example
            exampleLabel.font = UIFont.systemFont(ofSize: 20.0)
        }
        
        exampleLabel.textColor = UIColor.init(hexString: colorText)
    }
}
