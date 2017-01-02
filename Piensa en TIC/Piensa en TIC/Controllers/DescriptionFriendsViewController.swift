import UIKit

struct DescriptionFriendsConstants {
    static let friendsPrefix = "Apodo: "
    static let headerNoContentKey = "no_header"
    static let headerContentKey = "header"
    static let topImageNoContentKey = "no_top_image_name"
    static let topImageContentKey = "top_image_name"
    static let descriptionNoContentKey = "no_description"
    static let descriptionContentKey = "description"
}

class DescriptionFriendsViewController: GeneralViewController {

    @IBOutlet var topImage: UIImageView!
    @IBOutlet var headerLabel:UILabel!
    @IBOutlet var descriptionLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let color = UIColor(hexString:colorText)
        var friends = ""
        var first = false
        if let apodo1 = storage.getStringFromKey(key: KnowFriendsConstant.friendOne) {
            friends = "".concatenate(DescriptionFriendsConstants.friendsPrefix,apodo1)
            first = true
        }
        if let apodo2 = storage.getStringFromKey(key: KnowFriendsConstant.friendTwo) {
            var specialText = ""
            if first {
                specialText = "\n"
            }
            friends = "".concatenate(friends,specialText,DescriptionFriendsConstants.friendsPrefix,apodo2)
        }
        
        if friends == "" {
            if let topImageName = self.info[DescriptionFriendsConstants.topImageNoContentKey] {
                topImage.image = UIImage(named:topImageName)
            }
            if let headerText  = self.info[DescriptionFriendsConstants.headerNoContentKey] {
                headerLabel.text = headerText
            }
            if let descriptionText = self.info[DescriptionFriendsConstants.descriptionNoContentKey] {
//                descriptionLabel.attributedText = descriptionText
                let html = descriptionText as NSString
                descriptionLabel.attributedText = NSAttributedString.parseHtml(html)
            }
            
        } else {
            if let topImageName = self.info[DescriptionFriendsConstants.topImageContentKey] {
                topImage.image = UIImage(named:topImageName)
            }
            headerLabel.text = friends
            if let descriptionText = self.info[DescriptionFriendsConstants.descriptionContentKey] {
                descriptionLabel.text = descriptionText
            }
        }
        
        headerLabel.textColor = color
        descriptionLabel.textColor = color
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
