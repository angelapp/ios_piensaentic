import UIKit
import SwiftyJSON

struct DatePickerConstants {
    static let height:CGFloat = 240.0
}

class ProfileViewController: GeneralViewController {
    
    @IBOutlet var topImageView:UIImageView!
    
    @IBOutlet var nameTextField:UITextField!
    @IBOutlet var heroTextField:UITextField!
    @IBOutlet var emailTextField:UITextField!
    
    @IBOutlet var birthDateButton:UIButton!
    @IBOutlet var datePicker:UIDatePicker!
    @IBOutlet var containerPicker:UIView!
    @IBOutlet var backgroundContainer: UIView!
    
    var isDatePickerDisplayed:Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isDatePickerDisplayed = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        disableSwipe()
        initialSetup()
        fillWithData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup(){
        guard let topImage = self.info["top_image_name"] else {return}
        
        topImageView.image = UIImage(named: topImage)
        
        nameTextField.delegate = self
        heroTextField.delegate = self
        emailTextField.delegate = self
        
        nameTextField.drawBorder(UIColor.black, y: nameTextField.frame.size.height, key: "BottomBorder", dotted: true)
        heroTextField.drawBorder(UIColor.black, y: heroTextField.frame.size.height, key: "BottomBorder", dotted: true)
        emailTextField.drawBorder(UIColor.black, y: emailTextField.frame.size.height, key: "BottomBorder", dotted: true)
    }
    
    func disableSwipe() {
        guard let delegate = delegateSwipe else {
            return
        }
        
        delegate.disableSwipe()
    }
    
    func enableSwipe(){
        guard let delegate = delegateSwipe else {
            return
        }
        
        delegate.enableSwipe()
    }
    
    func fillWithData() {
        guard let user = getUser() else {return}
        nameTextField.text = user.firstName
        heroTextField.text = user.nickName
        birthDateButton.setTitle(user.birthDate, for: .normal)
        birthDateButton.setTitle(user.birthDate, for: .highlighted)
        birthDateButton.setTitle(user.birthDate, for: .selected)
        emailTextField.text = user.email
        
        enableSwipe()
    }
    
    func isTextEmpty(field:String!) -> Bool{
        guard let text = field else {return false}
        guard text.characters.count > 0 else {return false}
        return true
    }
    
    func validateFields() -> Bool {
        guard isTextEmpty(field: nameTextField.text) else {return false}
        guard isTextEmpty(field: heroTextField.text) else {return false }
        guard isTextEmpty(field: birthDateButton.titleLabel?.text) else {return false}
        guard isTextEmpty(field: emailTextField.text) else {return false}
        
        delegateSwipe.enableSwipe()
        
        let user = User(nameTextField.text, nickName: heroTextField.text, birthDate: birthDateButton.titleLabel?.text, email: emailTextField.text)
        let stringRepresentation = user.dictionary()
        if let data = User.archive(user:stringRepresentation) {
            storage.saveParameter(key: .user, value: data as AnyObject)
        }
        
        return true
    }
    
    @IBAction func showDatePicker(sender:Any?){
        guard !isDatePickerDisplayed else {return}
        displayDatePicker()
        isDatePickerDisplayed = true
    }
    
    @IBAction func datePickerAction(sender: AnyObject) {
       resignFirstResponder()
        hideDatePicker()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.string(from: datePicker.date)
        self.birthDateButton.setTitle(strDate, for: UIControlState.highlighted)
        self.birthDateButton.setTitle(strDate, for: UIControlState.normal)
        self.birthDateButton.setTitle(strDate, for: UIControlState.selected)
        
        isDatePickerDisplayed = false
        guard validateFields() else {return}
    }
    
    func displayDatePicker() {
//        containerPicker.transform = CGAffineTransform(translationX: 0, y: DatePickerConstants.height)
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.containerPicker.isHidden = false
            self.backgroundContainer.isHidden = false
            self.containerPicker.transform = CGAffineTransform(translationX: 0, y: 0)
            self.backgroundContainer.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
    }
    
    func hideDatePicker(){
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.containerPicker.transform = CGAffineTransform(translationX: 0, y: DatePickerConstants.height)
            self.backgroundContainer.transform = CGAffineTransform(translationX: 0, y: DatePickerConstants.height)
        }, completion: {_ in
            self.containerPicker.isHidden = true
            self.backgroundContainer.isHidden = true
        })
    }
}

extension ProfileViewController : UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let _ = validateFields()
        return true
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//        switch textField.tag {
//        case nameTextField.tag:
//            heroTextField.becomeFirstResponder()
//            break
//        case heroTextField.tag:
//            emailTextField.becomeFirstResponder()
//            break
//        case emailTextField.tag:
//            textField.resignFirstResponder()
//            break
//        default: break
//        }
////        validateFields()
//        return true
//    }
}
