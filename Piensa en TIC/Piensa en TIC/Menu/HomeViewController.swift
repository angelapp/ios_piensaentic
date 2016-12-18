import UIKit
import MFSideMenu

class HomeViewController: MFSideMenuContainerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.responds(to: #selector(getter: UIViewController.edgesForExtendedLayout)){
            self.edgesForExtendedLayout = UIRectEdge.all
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initialSetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Initial Setup
    func initialSetup() -> (){
        let mainConfigurator = MainConfigurator.sharedConfiguration
        let content = mainConfigurator.chapter(index: 0)
        print(content as Any)
        let homeStoryboard = UIStoryboard.init(name: "Menu", bundle: Bundle.main)
        let propertiesStoryboard = UIStoryboard.init(name: "Profile", bundle: Bundle.main)
        let navigationController = propertiesStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.profileController)
        let rightSideMenuViewController = homeStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.rightMenu)
        
//        let arrayContent:NSArray = content!["pages"] as! NSArray
//        let backgroundImageName = content!["backgroundName"] as! String
//        
//        (navigationController as! CarrouselChapterViewController).imagesArray = arrayContent
//        (navigationController as! CarrouselChapterViewController).imageName = backgroundImageName
        
        self.rightMenuViewController = rightSideMenuViewController
        self.centerViewController = navigationController
    }
    
    //MARK: Controller Actions
    @IBAction func leftSideMenuButtonPressed(sender:Any) -> (){
        self.menuContainerViewController.toggleLeftSideMenuCompletion {
        }
    }
    
    @IBAction func rightSideMenuButtonPressed(sender:Any) -> () {
        self.menuContainerViewController.toggleRightSideMenuCompletion { 
        }
    }
}
