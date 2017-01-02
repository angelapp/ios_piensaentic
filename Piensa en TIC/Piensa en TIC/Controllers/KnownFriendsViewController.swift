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
        fillWithData(field: field)
    }
    
    func fillWithData(field: UITextField) {
        var key: String = ""
        switch field.tag {
        case 0:
            key = Keys.nameFriendOne.rawValue
            break
        case 1:
            key = KnowFriendsConstant.friendOne
            break
        case 2:
            key = Keys.nameFriendTwo.rawValue
            break
        case 3:
            key = KnowFriendsConstant.friendTwo
            break
        default: break
        }
        
        field.text = storage.getStringFromKey(key: key)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension KnownFriendsViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false}
        switch textField.tag {
        case 0:
            storage.saveOptionChosen(key: Keys.nameFriendOne.rawValue , value: text)
            break
        case 1:
            storage.saveOptionChosen(key: KnowFriendsConstant.friendOne, value: text)
            break
        case 2:
            storage.saveOptionChosen(key: Keys.nameFriendTwo.rawValue, value: text)
            break
        case 3:
            storage.saveOptionChosen(key: KnowFriendsConstant.friendTwo, value: text)
            break
        default: break
        }

        return true
    }
}
