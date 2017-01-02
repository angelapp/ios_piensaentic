import UIKit

class JustTextViewController: GeneralViewController {

    @IBOutlet var textLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    func initialSetup(){
        guard let text = self.info["description"] else {return}
        textLabel.text = formattedText(text)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
