import UIKit

struct KnowFriendsConstant {
    static let friendOne = "apodo1"
    static let friendTwo = "apodo2"
    static let topDescription = "description"
}

class KnownFriendsViewController: GeneralViewController {

    @IBOutlet var topDescription:UILabel!
    @IBOutlet var nameField1:UITextField!
    @IBOutlet var nickNameField1:UITextField!
    @IBOutlet var nameField2:UITextField!
    @IBOutlet var nickNameField2:UITextField!
    
    @IBOutlet var box1:UIView!
    @IBOutlet var box2:UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let descriptionText = self.info[KnowFriendsConstant.topDescription] {
            topDescription.text = descriptionText
        }
        configureView(view: box1)
        configureView(view: box2)
        configureField(field: nameField1)
        configureField(field: nickNameField1)
        configureField(field: nameField2)
        configureField(field: nickNameField2)
    }
    
    func configureView(view:UIView){
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(hexString:"#4C7EDAFF")?.cgColor
    }
    
    func configureField(field:UITextField){
        field.drawBorder(UIColor(hexString:"#4C7EDAFF"), y: field.frame.size.height, key: "BottomBorder", dotted: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension KnownFriendsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var currentString = textField.text! as NSString
        if (currentString.length - 1) < range.location {
            currentString = "".concatenate(currentString, string) as NSString
        } else {
            currentString = currentString.replacingCharacters(in: range, with: string) as NSString
        }
        
        if textField.tag == 1 {
            storage.saveOptionChosen(key: KnowFriendsConstant.friendOne, value: currentString as String)
        } else if textField.tag == 3 {
            storage.saveOptionChosen(key: KnowFriendsConstant.friendTwo, value: currentString as String)
        }
        return true
    }
}
