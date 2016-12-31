import UIKit
protocol CloseAlertDelegate {
    func dismissAlertView()
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
        guard let user = getUser() else {return}
        guard let imageBackground = self.info["second_background_image"] else {return}
        guard let format = self.info["format"] else { return}
        
        centerImage.image = UIImage(named: imageBackground)
        let contentFormatted = String.init(format: format, user.firstName, user.nickName, user.birthDate, user.email)
        summarizeLabel.text = contentFormatted
        
        showAlert()
    }
    
    func showAlert(){
        
        UIView.animate(withDuration: 0, delay: 1, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.alertView = self.storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.termsController) as! TermsViewController
            self.alertView.delegate = self
                if let view = self.alertView.view {
                    self.navigationController?.view.addSubview(view)
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
}
