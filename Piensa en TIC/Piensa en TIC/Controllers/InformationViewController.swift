import UIKit

class InformationViewController: GeneralViewController {

    @IBOutlet var topImage:UIImageView!
    @IBOutlet var secondaryImage:UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var button:UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let imageName = self.info["top_image_name"] else { return}
        guard let descriptionText = self.info["description"] else { return}
        
        topImage.image = UIImage(named:imageName)
        descriptionLabel.text = formattedText(descriptionText)
        descriptionLabel.textColor = UIColor.init(hexString: colorText)
        
        if let buttonImageName = self.info["button"] {
            button.isHidden = false
    
            button.setImage(UIImage(named: buttonImageName), for: .normal)
        } else {
            button.isHidden = true
    
        }
        
        guard storage.getImage() != nil else {return}
        if let _ = self.info["hasSecondaryImage"]{
            self.secondaryImage.isHidden = false
            self.secondaryImage.image = storage.getImage()
        } else {
            self.secondaryImage.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didButtonPress(sender:Any!) {
        if let buttonEvent = self.info["buttonEvent"] {
            if buttonEvent == "photo" {
                self.loadImageButtonTapped(sender: sender as! UIButton)
            }
            else if buttonEvent == "checkData" {
                guard let metadata = storage.getMetadata() as! [String]! else {
                    showAlertInfoView("No hay información para mostrar!")
                    return
                }
//                    self.showAlert(title: "Metadatos", message: storage.getMetadata() as! String)
                var result = String()
                for info in metadata {
                    result = result.appendingFormat("%@", info)
                }
                self.showAlertInfoView(result)
                
            } else if buttonEvent == "send_message" {
                shareFunctionality()
            }
        }
    }

}
