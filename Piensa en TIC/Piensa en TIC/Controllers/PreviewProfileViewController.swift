import UIKit
protocol CloseAlertDelegate {
    func dismissAlertView()
    func dismissAlertViewAndBack()
}

class PreviewProfileViewController: GeneralViewController {

    @IBOutlet var summarizeLabel: UILabel!
    @IBOutlet var centerImage: UIImageView!
    
    var alertView: TermsViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup() {
        guard let imageBackground = self.info["second_background_image"] else {return}
        guard let format = self.info["format"] else { return}
        
        centerImage.image = UIImage(named: imageBackground)
        let contentFormatted = formatPreviewProfile(format)
        summarizeLabel.attributedText = contentFormatted
//        summarizeLabel.text = contentFormatted
        
        showAlert()
    }
    
    func formatPreviewProfile(_ formatted: String) -> NSAttributedString {
        guard let user = getUser() else {return NSAttributedString()}
        let completedString = String(format: formatted, String(",\(user.firstName!),\n"), String(",\n\(user.nickName.uppercased()),\n"), String(",\(user.birthDate!),\n"), String(",\n\(user.email!),"))
        guard let format = completedString.split(by: ",") else {return NSAttributedString(string: completedString)}
        let fonts = [UIFont.boldSystemFont(ofSize: 20.0),UIFont.systemFont(ofSize: 17.0),UIFont.boldSystemFont(ofSize: 23.0),UIFont.systemFont(ofSize: 20.0),UIFont.systemFont(ofSize: 20.0),UIFont.systemFont(ofSize: 17.0),UIFont.systemFont(ofSize: 20.0)]
        
        return NSAttributedString().stringWithWords(words: format as! [String], fonts: fonts, color: UIColor(hexString: colorText)!)
        
    }
    
    func showAlert(){
        
        UIView.animate(withDuration: 0, delay: 1, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                guard let email = self.storage.getParameterFromKey(key: Keys.email) else {
                    self.alertView = self.storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.termsController) as! TermsViewController
                    self.alertView.delegate = self
                    if let view = self.alertView.view {
                        self.navigationController?.view.addSubview(view)
                    }
                    return
                }
            }, completion: {_ in
                
            }
        )
    }
    
    @IBAction func didButtonPress(sender: Any!) -> () {
        guard self.delegate != nil else { return}
        self.delegate.processChapter()
    }

}

extension PreviewProfileViewController: CloseAlertDelegate {
    func dismissAlertView() {
        if self.alertView != nil {
            self.alertView.removeFromParentViewController()
            self.alertView.view.removeFromSuperview()
            self.alertView = nil
        }
    }
    
    func dismissAlertViewAndBack() {
        dismissAlertView()
        guard delegateTransition != nil else {return}
        delegateTransition.backOnePage()
    }
}
