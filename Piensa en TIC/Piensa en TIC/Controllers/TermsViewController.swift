import UIKit

class TermsViewController: UIViewController {

    @IBOutlet var acceptButton:UIButton!
    @IBOutlet var refuseButton:UIButton!
    
    var delegate: CloseAlertDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBackgroundBlur()
        acceptButton.addTarget(self, action: #selector(TermsViewController.actionButtonAccept), for: .touchUpInside)
        refuseButton.addTarget(self, action: #selector(TermsViewController.actionButtonRefuse), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBackgroundBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        view.insertSubview(blurEffectView, at: 0)
    }

    func actionButtonAccept() {
        Network.createUser(termsConditionalAccepted: true, completion: { (response) in
            switch response {
            case .succeeded(let succeeded, let message):
                if succeeded {
                    guard self.delegate != nil else {return}
                    self.delegate.dismissAlertView()
                } else {
                    self.showAlert(title: "Error", message: message) { _ in
                        guard self.delegate != nil else {return}
                        self.delegate.dismissAlertViewAndBack()
                    }
                }
                break
            case .error(let error):
                
                print(error.debugDescription)
                break
            default: break
            }
            
        })
        
    }
    
    func actionButtonRefuse() {
        
    }
}
