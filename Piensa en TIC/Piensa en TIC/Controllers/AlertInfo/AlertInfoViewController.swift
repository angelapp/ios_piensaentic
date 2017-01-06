import UIKit

class AlertInfoViewController: UIViewController {
    
    @IBOutlet var informationLabel:UILabel!
    @IBOutlet var box:UIView!
    var delegate:AlertInfoViewDelegate!
    var message:String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundBlur()
        setupBox()
        setupView()
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
    
    func setupBox(){
        box.layer.borderColor = UIColor.black.cgColor
        box.layer.borderWidth = 1.0
        box.layer.cornerRadius = 7.0
    }

    func setupView(){
        guard message != nil else {
            informationLabel.text = "No hay información para mostrar."
            return
        }
        
        informationLabel.text = message
    }
    
    @IBAction func closeView(sender:Any!) {
        guard delegate != nil else { return }
        delegate.dismissAlert()
    }

}
