import UIKit

class SummarySpyFormViewController: GeneralViewController {

    @IBOutlet var plateBox: UIView!
    @IBOutlet var placesBox: UIView!
    @IBOutlet var identificationBox: UIView!
    
    @IBOutlet var plateLabel: UILabel!
    @IBOutlet var contactInfoLabelOne: UILabel!
    @IBOutlet var placesLabel: UILabel!
    @IBOutlet var contactInfoLabelTwo: UILabel!
    @IBOutlet var identificationLabel: UILabel!
    @IBOutlet var contactInfoLabelThree: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureBorder(view: plateBox)
        configureBorder(view: placesBox)
        configureBorder(view: identificationBox)
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
        plateLabel.text = storage.getStringFromKey(key: "".concatenate(SpyFormIdentifiers.descriptionId, SpyFormIdentifiers.firstScreen))
        contactInfoLabelOne.text = storage.getStringFromKey(key: "".concatenate(SpyFormIdentifiers.contact, SpyFormIdentifiers.firstScreen))
        placesLabel.text = storage.getStringFromKey(key: "".concatenate(SpyFormIdentifiers.descriptionId, SpyFormIdentifiers.twoScreen))
        contactInfoLabelTwo.text = storage.getStringFromKey(key: "".concatenate(SpyFormIdentifiers.contact, SpyFormIdentifiers.twoScreen))
        identificationLabel.text = storage.getStringFromKey(key: "".concatenate(SpyFormIdentifiers.descriptionId, SpyFormIdentifiers.threeScreen))
        contactInfoLabelThree.text = storage.getStringFromKey(key: "".concatenate(SpyFormIdentifiers.contact, SpyFormIdentifiers.threeScreen))
    }
    
    func configureBorder(view:UIView){
        let color = UIColor(hexString: colorText)
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 2
//        view.layer.borderColor = UIColor(hexString:"#4C7EDAFF")?.cgColor
        view.layer.borderColor = color?.cgColor
    }

}
