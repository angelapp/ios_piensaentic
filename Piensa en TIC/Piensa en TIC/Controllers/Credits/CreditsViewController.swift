import UIKit

class CreditsViewController: GeneralViewController {

    @IBOutlet var creditsTextView: UITextView!
    @IBOutlet var footerImageView: UIImageView!
    
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
        guard let image = self.info["bottom_image_name"] else {return}
        guard let credits = self.info["credits"] else {return}
        guard let linksString = self.info["links"] else {return}
        guard let links = linksString.split(by: ",") else {return}
        
        creditsTextView.attributedText = processDescriptionWithLinks(credits, links: links as! [String], font: UIFont.systemFont(ofSize: 16.0))
        creditsTextView.textAlignment = .center
        creditsTextView.contentMode = .scaleAspectFit
        creditsTextView.tintColor = UIColor(hexString: colorText)
        
        footerImageView.image = UIImage(named: image)
    }
}
