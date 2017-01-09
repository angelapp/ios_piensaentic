import UIKit

protocol AlertInfoViewDelegate {
    func dismissAlert()
}

class GeneralViewController: UIViewController {
    
    var index:Int!
    var info:[String:String]!
    var colorText:String!
    var colorSelected:UIColor!
    let imagePicker = UIImagePickerController()
    var imageSaved:UIImage!
    var metadata:AnyObject!
    var activityName:String!
    let storage = Storage.shared
    var delegate:CompleteChapterDelegate!
    var delegateSwipe:DataSourceEnableSwipe!
    var delegateTransition: SwipeDelegate!
    
    var alertViewInfo:AlertInfoViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if colorText != nil {
            colorSelected = UIColor(hexString: colorText)!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUserNameFromUserDefaults() -> String {
        let userDefaults = UserDefaults.standard
        guard let name:String = userDefaults.object(forKey: "userName") as! String? else {return ""}
     
        return name
    }
    
    func matchRegex(pattern: String, value:String) -> Bool{
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: value, options: [], range: NSRange(location: 0, length: value.characters.count))
        return matches.count > 0
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel) {(_) in
            alert.dismiss(animated: false, completion: nil)
        }
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

extension GeneralViewController {
    func processExample(_ example:String) -> NSAttributedString {
        let shouldBeBold = example.contains("Mshtscnell") || example.contains("M5ht5cne11")
        let array = example.split(by: "|")
        guard let arrayResult = array else { return NSAttributedString()}
        let words = (arrayResult[0] as! String).split(by: ",")
        let fonts = (arrayResult[1] as! String).split(by: ",")
        guard let wordsResult = words else {return NSAttributedString()}
        guard let fontsResult = fonts else {return NSAttributedString()}
        var wordsResponse = [AnyObject]()
        for i in 0..<wordsResult.count {
            let word = wordsResult[i] as! String
            let newText = word.replacingOccurrences(of: "u015", with: "\n")
            
            wordsResponse.append(newText as AnyObject)
        }
        
        var fontsResponse = [AnyObject]()
        for i in 0..<fontsResult.count {
            let fontSize = fontsResult[i] as! String
            let cast = Int(fontSize)
            if shouldBeBold {
                if i == fontsResult.count - 1 {
                    fontsResponse.append(UIFont.boldSystemFont(ofSize: CGFloat(cast!)))
                    continue
                }
            }
            fontsResponse.append(UIFont.systemFont(ofSize: CGFloat(cast!)))
        }
        
        
        
        let result = NSAttributedString().stringWithWords(words: wordsResponse as! [String], fonts: fontsResponse as! [UIFont], color:UIColor(hexString: colorText)!)
        return result
    }
    
    func processNickname(_ format:String) -> NSAttributedString {
        guard let user = getUser() else {
            return NSAttributedString(string: String.init(format: format, ""))
        }
        
        let formatted = format.replacingOccurrences(of: "\\n", with: "u015").replacingOccurrences(of: "u015", with: "\n").replacingOccurrences(of: "%@", with: "")
        let words = [user.nickName.uppercased(), formatted]
        let fonts = [UIFont.boldSystemFont(ofSize: 20), UIFont.systemFont(ofSize: 20)]
        
        
        let result = NSAttributedString().stringWithWords(words: words, fonts: fonts, color: UIColor(hexString: colorText)!)
        return result
    }
    
    func processDescriptionWithLinks(_ description:String, links:[String]) -> NSAttributedString {
        let words = description.split(by: ",")
        guard let wordsResult = words else {return NSAttributedString()}
        var wordsResponse = [AnyObject]()
        for i in 0..<wordsResult.count {
            
            let word = wordsResult[i] as! String
            
            let newText1 = word.replacingOccurrences(of: "\\n", with: "u015").replacingOccurrences(of: "u015", with: "\n")
            let newText = newText1.replacingOccurrences(of: "u2022", with: "• ")
            
            wordsResponse.append(newText as AnyObject)
        }
        
        let result = NSAttributedString().stringWithWords(words: wordsResponse as! [String], links: links, color:UIColor(hexString: colorText)!)
        return result
    }
    
    func processDescriptionWithLinks(_ description:String, links:[String], font:UIFont!, linkColor:UIColor? = UIColor.white) -> NSAttributedString {
        let words = description.split(by: ",")
        guard let wordsResult = words else {return NSAttributedString()}
        var wordsResponse = [AnyObject]()
        for i in 0..<wordsResult.count {
            
            let word = wordsResult[i] as! String
            
            let newText1 = word.replacingOccurrences(of: "\\n", with: "u015").replacingOccurrences(of: "u015", with: "\n")
            let newText = newText1.replacingOccurrences(of: "u2022", with: "• ")
            
            wordsResponse.append(newText as AnyObject)
        }
        
        let result = NSAttributedString().stringWithWords(words: wordsResponse as! [String], links: links, color:UIColor(hexString: colorText)!, font: font, linkColor: linkColor!)
        return result
    }
}


extension GeneralViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate{
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Camera", "Photo Library")
        actionSheet.show(in: self.view)
    }
    
    //MARK: delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        if let infoPic = info[UIImagePickerControllerMediaMetadata] {
            print(infoPic)
            storage.setMetadata(metadata: infoPic as AnyObject!)
        }
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            self.imageView.contentMode = UIViewContentMode.scaleAspectFit
//            self.imageView.image = pickedImage
            storage.setImage(image: pickedImage)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: UIActionSheet delegate Methods
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        var shouldStop = false
        switch (buttonIndex){
            
        case 0:
            shouldStop = true
            break
        case 1:
            imagePicker.sourceType = .camera
            break
        case 2:
            imagePicker.sourceType = .photoLibrary
            break
        default:break
            
        }
        
        if shouldStop {
            return
        }
        storage.saveParameter(key: .latestChapter, value: "chapter1" as AnyObject)
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func formattedText(_ word:String) -> String{
        return word.replacingOccurrences(of: "u015", with: "\n")
    }

}

extension GeneralViewController {
    func getUser() -> User! {
        guard let data = storage.getParameterFromKey(key: .user) as! Data! else { return nil}
        guard let dic = User.unarchive(data: data) else { return nil}
        let user = User.initUser(fromDic: dic)
        return user
    }
}

extension GeneralViewController {
    func shareFunctionality() {
        let staticText = "Encriptando con Piensa En TIC"
        let activityViewController = UIActivityViewController(activityItems: [staticText], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler  = { activity, success, items, error in
            print("Activitycontroller ",activity ?? "")
            print("items ",items ?? "")
        }
        self.present(activityViewController, animated: true, completion: {})

    }
}

extension GeneralViewController:AlertInfoViewDelegate {
    func showAlertInfoView(_ message: String! = "") {
        guard alertViewInfo == nil else {return}
        
        alertViewInfo = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.alertViewInfo) as! AlertInfoViewController
        
        alertViewInfo.message = message
        alertViewInfo.delegate = self
        
        self.navigationController?.view.addSubview(alertViewInfo.view)
    }
    
    func dismissAlert() {
        guard alertViewInfo != nil else {return}
        
        alertViewInfo.removeFromParentViewController()
        alertViewInfo.view.removeFromSuperview()
        alertViewInfo = nil
    }
}
