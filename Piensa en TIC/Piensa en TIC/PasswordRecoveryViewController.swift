//
//  PasswordRecoveryViewController.swift
//  Piensa en TIC
//
//  Created by Daniel Trujillo on 12/29/16.
//
import UIKit

class PasswordRecoveryViewController: UIViewController {
    

    
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup(){
        emailTextField.delegate = self
        
        
        emailTextField.drawBorder(UIColor.black, y: emailTextField.frame.size.height, key: "BottomBorder", dotted: true)
        
    }
    
    @IBAction func buttonSendClicked(_ sender: UIButton) {
        
        guard validateFields() else {
            showAlert(title: "Error", message: "Por favor revise el email ingresado e intente nuevamente.")
            return
        }
        
        let completion : ResponseClosure = { response in
            switch response {
            case .succeeded(let succeeded, _):
                if succeeded {
                    _ = self.navigationController?.popViewController(animated: true)
                } else {
                    self.showAlert(title: "Error", message: "Por favor revise el email ingresado e intente nuevamente.")
                }
                break
            case .error(_) :
                self.showAlert(title: "Error", message: "Por favor revise el email ingresado e intente nuevamente.")
                break
            default: break
            }
            
        }
        
        guard let request = Network.passwordRecovery(email: emailTextField.text!, completion: completion), request else {
            showAlert(title: "Error", message: "Email no corresponde con el registrado en la aplicación.")
            return
        }
        
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel) {(_) in
            alert.dismiss(animated: false, completion: nil)
        }
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func isTextEmpty(field:String!) -> Bool{
        guard let text = field else {return false}
        guard text.characters.count > 0 else {return false}
        return true
    }
    
    func validateFields() -> Bool {
        guard isTextEmpty(field: emailTextField.text), (emailTextField.text?.isValidEmail())! else {return false}
        return true
    }
    
}


extension PasswordRecoveryViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case emailTextField.tag:
            emailTextField.becomeFirstResponder()
            break
        default: break
        }
        //        validateFields()
        return true
    }
}
