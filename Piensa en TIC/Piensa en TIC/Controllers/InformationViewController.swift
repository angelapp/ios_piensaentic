import UIKit

class InformationViewController: GeneralViewController {

    @IBOutlet var topImage:UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var button:UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let imageName = self.info["top_image_name"] else { return}
        guard let descriptionText = self.info["description"] else { return}
        
        topImage.image = UIImage(named:imageName)
        descriptionLabel.text = descriptionText
        descriptionLabel.textColor = UIColor.init(hexString: colorText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
