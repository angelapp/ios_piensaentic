import UIKit

class IntroInformationViewController: UIViewController {
    
    @IBOutlet var topImage:UIImageView!
    @IBOutlet var descriptionLabel:UILabel!
    @IBOutlet var backgroundButton:UIImageView!
    @IBOutlet var button:UIButton!
    
    var index:Int!
    var delegate:DismissIntro!
    var content:[String:String]!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadInformation(){
        if let topImageName = content["top_image"] {
            topImage.image = UIImage(named: topImageName)
        }
        
        descriptionLabel.text = content["description"]
        if let background = content["background"] {
            button.isHidden = false
            backgroundButton.isHidden = false
            backgroundButton.image = UIImage(named: background)
        }

    }

    @IBAction func didPressButton(_ sender: Any!) -> () {
        guard self.delegate != nil else {
            return
        }
        self.delegate.dismiss()
    }

}
