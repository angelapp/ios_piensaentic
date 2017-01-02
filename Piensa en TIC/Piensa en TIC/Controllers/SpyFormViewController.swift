import UIKit

struct SpyFormIdentifiers {
    static let firstScreen = "one"
    static let twoScreen = "two"
    static let threeScreen = "three"
    static let descriptionId = "description-"
    static let contact = "contact"
}

class SpyFormViewController: GeneralViewController {

    @IBOutlet var topImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var firstTitle: UILabel!
    @IBOutlet var secondTitle: UILabel!
    
    @IBOutlet var firstTextView: UITextView!
    @IBOutlet var secondTextView: UITextView!
    
    @IBOutlet var box1: UIView!
    
    var screen:String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView(view: box1)
        initialSetup()
        drawBottomBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView(view:UIView){
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor(hexString:"#000000FF")?.cgColor
    }
    
    func initialSetup(){
        guard let topImageName = self.info["top_image_name"] else { return}
        guard let descriptionText = self.info["description"] else { return}
        guard let firstText = self.info["firstTitle"] else { return}
        guard let secondText = self.info["secondTitle"] else { return}
        guard let screenid = self.info["screen"] else {return}
        
        let color = UIColor(hexString: colorText)
        topImage.image = UIImage(named:topImageName)
        descriptionLabel.text = descriptionText
        descriptionLabel.textColor = color
        
        firstTitle.text = firstText
        firstTitle.textColor = color
        
        secondTitle.text = secondText
        secondTitle.textColor = color
        
        screen = screenid
        
        fillWithData()
    }
    
    func drawBottomBorder() {
        let color = UIColor(hexString: colorText)
        firstTextView.drawSeparator(.Down, color: color!, dotted: true)
        secondTextView.drawSeparator(.Down, color: color!, dotted: true)
    }
    
    
    func fillWithData() {
        guard let screen = screen else { return}
        guard let description = storage.getStringFromKey(key: "".concatenate(SpyFormIdentifiers.descriptionId, screen)) else {return}
        guard let contact     = storage.getStringFromKey(key: "".concatenate(SpyFormIdentifiers.contact, screen)) else { return}
        
        firstTextView.text = description
        secondTextView.text = contact
    }
}

extension SpyFormViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var currentString = textView.text! as NSString
        if (currentString.length - 1) < range.location {
            currentString = "".concatenate(currentString, text) as NSString
        } else {
            currentString = currentString.replacingCharacters(in: range, with: text) as NSString
        }
        
        guard let screen = screen else { return false}
        
        switch textView.tag {
            case 0:
                storage.saveOptionChosen(key: "".concatenate(SpyFormIdentifiers.descriptionId, screen), value: currentString as String)
                break
            case 1:
                storage.saveOptionChosen(key: "".concatenate(SpyFormIdentifiers.contact, screen), value: currentString as String)
                break
            default: break
        }
        
        return true
    }
}
