import UIKit
import youtube_ios_player_helper
import Foundation

struct EpilogueConstants {
    static let heightTopImage:CGFloat = 132.0
    static let heightTopImageWithoutPhoto:CGFloat = 40.0
}

class EpilogueViewController: GeneralViewController {
    
    @IBOutlet var topImage: UIImageView!
    @IBOutlet var topImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet var descriptionImage: UIImageView!
    @IBOutlet var descriptionLabel: UITextView!
    @IBOutlet var contnue: UIButton!
    @IBOutlet var backgroundImage:UIImageView!
    @IBOutlet var videoView:YTPlayerView!

    @IBOutlet var blankView: UIView!
    @IBOutlet var textView:UITextView!
    @IBOutlet var box:UIView!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let topImageName = self.info["top_image_name"] else { return}
        guard let descriptionText = self.info["description"] else { return}
        
        if topImageHeightConstraint != nil{
            if topImageName == "" {
                topImageHeightConstraint.constant = EpilogueConstants.heightTopImageWithoutPhoto
            } else {
                topImageHeightConstraint.constant = EpilogueConstants.heightTopImage
            }
        }
        
        if topImage != nil {
            topImage.image = UIImage(named:topImageName)
        }
        if (descriptionText.range(of:"contraseña") != nil){
            descriptionLabel.textContainerInset = UIEdgeInsetsMake(80, 0, 40,0)
        }
        
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = descriptionText
        descriptionLabel.textColor = UIColor(hexString: colorText)
    
        if let imageName = self.info["image"] {
            descriptionImage.image = UIImage(named:imageName)
            videoView.isHidden = true
            descriptionImage.isHidden = false
        }
    
        if let buttonText = self.info["button"] {
            backgroundImage.image = UIImage(named:buttonText)
        }
        
        if let linksString = self.info["links"]{
            guard let links = linksString.split(by: ",") else {return}
            descriptionLabel.isSelectable = true
            descriptionLabel.attributedText = processDescriptionWithLinks(descriptionText, links: links as! [String])
            descriptionLabel.textAlignment = .center
            descriptionLabel.tintColor = UIColor.init(hexString: colorText)
        }
        
        if let videoId = self.info["videoId"] {
            videoView.isHidden = false
            descriptionImage.isHidden = true
//            videoView.delegate = self
            videoView.setLoop(false)
            
            let playerVars = ["controls": NSNumber(value: 1),
                              "playsinline": NSNumber(value: 1),
                              "autohide": NSNumber(value: 1),
                              "showInfo": NSNumber(value: 0),
                              "modestbranding": NSNumber(value: 0)]
            
            videoView.load(withVideoId: videoId, playerVars: playerVars)
        }

        if box != nil {
            configureBorder(box)
        }
        
    }
    
    func actionButton(sender:Any?) -> () {
        guard let segue = self.info["segue"] else {return}
        performSegue(withIdentifier: segue, sender: nil)
    }
    
    func configureBorder(_ view:UIView){
        let color = UIColor(hexString: colorText)
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 2
        //        view.layer.borderColor = UIColor(hexString:"#4C7EDAFF")?.cgColor
        view.layer.borderColor = color?.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
