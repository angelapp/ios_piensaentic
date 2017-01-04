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

    @IBOutlet var titleQuestion: UILabel!
    @IBOutlet var titleAnswerOne: UILabel!
    @IBOutlet var titleAnswerTwo: UILabel!
    @IBOutlet var answerOne: UIButton!
    @IBOutlet var answerTwo: UIButton!

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
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
    
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
            descriptionLabel.contentMode = .scaleAspectFit
            descriptionLabel.tintColor = UIColor(hexString: colorText)
        }
        
        if let videoId = self.info["videoId"] {
            videoView.isHidden = false
            descriptionImage.isHidden = true
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
            fillWithData()
            
            textView.delegate = self
            
            if let questionText = self.info["question"] {
                titleQuestion.text = questionText
                titleQuestion.textColor = UIColor(hexString: colorText)
            }
            
            if let options = self.info["select_options"] {
                guard let splited = options.split(by: "|") else {return}
                titleAnswerOne.text = splited[0] as! String
                titleAnswerOne.textColor = UIColor(hexString: colorText)
                titleAnswerTwo.text = splited[1] as! String
                titleAnswerTwo.textColor = UIColor(hexString: colorText)
            }
        }
        
    }
    
    @IBAction func actionButton(sender:Any?) -> () {
        guard let _ = self.info["segue"] else {return}
        guard delegate != nil else {return}
        delegate.processChapter()
    }
    
    func configureBorder(_ view:UIView){
        let color = UIColor(hexString: colorText)
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 2
        //        view.layer.borderColor = UIColor(hexString:"#4C7EDAFF")?.cgColor
        view.layer.borderColor = color?.cgColor
    }
    
    func fillWithData(){
        guard let spyInfo = storage.getStringFromKey(key: Keys.spyInfo.rawValue) else {return}
        textView.text = spyInfo
        guard let optionSelected = storage.getStringFromKey(key: Keys.spyAnswerSelected.rawValue) else {return}
        
        answerOne.isSelected = false
        answerTwo.isSelected = false
        if optionSelected == "1"{
            answerOne.isSelected = true
        } else {
            answerTwo.isSelected = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectionAnswer(sender: Any!){
        answerOne.isSelected = false
        answerTwo.isSelected = false
        
        let button = sender as! UIButton!
        if button == answerOne {
            answerOne.isSelected = true
            storage.saveOptionChosen(key: Keys.spyAnswerSelected.rawValue, value: "1")
        } else {
            answerTwo.isSelected = true
            storage.saveOptionChosen(key: Keys.spyAnswerSelected.rawValue, value: "2")
        }
    }
    
    
}

extension EpilogueViewController: UITextViewDelegate {

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        let text = textView.text
        storage.saveOptionChosen(key: Keys.spyInfo.rawValue, value: text!)
        return true
    }
    
}
