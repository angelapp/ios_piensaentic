import UIKit

class SpyFormViewController: GeneralViewController {

    @IBOutlet var topImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var firstTitle: UILabel!
    @IBOutlet var secondTitle: UILabel!
    
    @IBOutlet var firstTextView: UITextView!
    @IBOutlet var secondTextView: UITextView!
    
    @IBOutlet var box1: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView(view: box1)
        initialSetup()
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
        
        let color = UIColor(hexString: colorText)
        topImage.image = UIImage(named:topImageName)
        descriptionLabel.text = descriptionText
        descriptionLabel.textColor = color
        
        firstTitle.text = firstText
        firstTitle.textColor = color
        
        secondTitle.text = secondText
        secondTitle.textColor = color
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
        
        return true
    }
}
