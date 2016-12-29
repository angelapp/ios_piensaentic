import UIKit

class GeneralViewController: UIViewController {
    
    var index:Int!
    var info:[String:String]!
    var colorText:String!
    let imagePicker = UIImagePickerController()
    var imageSaved:UIImage!
    var metadata:AnyObject!
    let storage = Storage.shared

    override func viewDidLoad() {
        super.viewDidLoad()
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
            
            fontsResponse.append(UIFont.systemFont(ofSize: CGFloat(cast!)))
        }
        
        let result = NSAttributedString().stringWithWords(words: wordsResponse as! [String], fonts: fontsResponse as! [UIFont], color:UIColor(hexString: colorText)!)
        return result
    }
    
    func processDescriptionWithLinks(_ description:String, links:[String]) -> NSAttributedString {
        let words = description.split(by: ",")
        guard let wordsResult = words else {return NSAttributedString()}
        var wordsResponse = [AnyObject]()
        for i in 0..<wordsResult.count {
            
            let word = wordsResult[i] as! String
            let newText1 = word.replacingOccurrences(of: "u015", with: "\n")
            let newText = newText1.replacingOccurrences(of: "u2022", with: "• ")
            
            wordsResponse.append(newText as AnyObject)
        }
        
        let result = NSAttributedString().stringWithWords(words: wordsResponse as! [String], links: links, color:UIColor(hexString: colorText)!)
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
        switch (buttonIndex){
            
        case 0: break
        case 1:
            imagePicker.sourceType = .camera
            break
        case 2:
            imagePicker.sourceType = .photoLibrary
            break
        default:break
            
        }
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    
    func formattedText(_ word:String) -> String{
        return word.replacingOccurrences(of: "u015", with: "\n")
    }

}
