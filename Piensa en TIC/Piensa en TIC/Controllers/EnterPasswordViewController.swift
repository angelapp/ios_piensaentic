import UIKit

class EnterPasswordViewController: GeneralViewController {

    @IBOutlet var descriptionLabel:UILabel!
    @IBOutlet var password:UITextField!
    @IBOutlet var confirmPassword:UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSetup()
        password.drawBorder(UIColor.init(hexString: self.colorText), y: password.frame.size.height, key: "BottomBorder", dotted: true)
        confirmPassword.drawBorder(UIColor.init(hexString: self.colorText), y: confirmPassword.frame.size.height, key: "BottomBorder", dotted: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup(){
        var nickName: String = ""
        if let user = getUser() {
            nickName = user.nickName
        }
        
        guard let descriptionText = self.info["description"] else { return}
        descriptionLabel.attributedText = processNickname(descriptionText)
        descriptionLabel.textColor = UIColor(hexString:colorText)
    }
    
    //MARK: validate fields
    func validateFields() -> Bool{
        guard let password = password.text else {return false}
        guard password.characters.count > 0 else {return false}
        guard password.characters.count >= 6 else {return false}
        guard let confirmPassword = confirmPassword.text else {return false}
        guard confirmPassword.characters.count > 0 else {return false}
        
        guard password == confirmPassword else {return false}
        
        guard matchRegex(pattern: Constants.patternPassword, value: password) else { return false}
        
        
        return true
    }
    
    @IBAction func createPassword(sender:Any!){
        guard validateFields() else {
            showAlert(title: "Error", message: "Por favor verifica la informacion y vuelve a intentarlo.")
            return
        }
        storage.saveParameter(key: .password, value: password.text as AnyObject)
        showAlert(title: "Exito", message: "Su contraseña ha sido creada con exito.")
    }
    
}
