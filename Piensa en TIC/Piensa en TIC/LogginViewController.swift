//
//  LogginViewController.swift
//  Piensa en TIC
//
//  Created by Daniel Trujillo on 12/29/16.
//

import UIKit
import Crashlytics

class LogginViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var passwordText: UITextField!
    var savedPassword:String = ""
    let storage = Storage.shared
    
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
    
    func textFieldDidChange(textField: UITextField){
        
    }
    
    @IBAction func onPasswordWritting(_ sender: UITextField) {
        
        let password = passwordText.text
        guard isTextEmpty(field: password), password == storage.getParameterFromKey(key: .password) as! String! else {return}
        //if password == savedPassword{
        if true{
            
            print("password corresponding")
            let storyboard = UIStoryboard(name: "Menu", bundle: nil)
            present(storyboard.instantiateInitialViewController()!, animated: false, completion: nil)
            
        } else {
            print("password not corresponding")
        }
    }
    
    func initialSetup(){
        passwordText.delegate = self
        passwordText.drawBorder(UIColor.black, y: passwordText.frame.size.height, key: "BottomBorder", dotted: true)
        savedPassword = getPassword()
    }
    
    func getPassword()-> String! {
        let storage = Storage.shared
        guard let data = storage.getParameterFromKey(key: .password) as! String! else { return ""}
        return data
    }

    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func isTextEmpty(field:String!) -> Bool{
        guard let text = field else {return false}
        guard text.characters.count > 0 else {return false}
        return true
    }
    
    func validateFields() -> Bool {
        //guard isTextEmpty(field: passwordTextField.text) else {return false}
        return true
    }
}


extension LogginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case passwordText.tag:
            passwordText.becomeFirstResponder()
            break
        default: break
        }
        //        validateFields()
        return true
    }
}

