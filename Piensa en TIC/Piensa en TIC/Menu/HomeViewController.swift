import UIKit
import MFSideMenu

protocol SelectRightMenuItem {
    func selectRightMenuItem(content:String!)
}

class HomeViewController: MFSideMenuContainerViewController {
    
    let mainConfigurator = MainConfigurator.sharedConfiguration
    var content:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.responds(to: #selector(getter: UIViewController.edgesForExtendedLayout)) {
            self.edgesForExtendedLayout = UIRectEdge.all
        }
        
        content = mainConfigurator.chapter(index: 0)
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
        
        let homeStoryboard = UIStoryboard.init(name: "Menu", bundle: Bundle.main)
        let propertiesStoryboard = UIStoryboard.init(name: "Chapters", bundle: Bundle.main)
        let navigationController = propertiesStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.chapterMain)
        let rightSideMenuViewController = homeStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.rightMenu)
        
        let arrayContent:NSArray = content!["pages"] as! NSArray
        let backgroundImageName = content!["backgroundName"] as! String
        
        (navigationController as! CarrouselChapterViewController).imagesArray = arrayContent
        (navigationController as! CarrouselChapterViewController).imageName = backgroundImageName
        (navigationController as! CarrouselChapterViewController).generalContent = content
        
        (rightSideMenuViewController as! RightViewController).delegate = self
        
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

extension HomeViewController: SelectRightMenuItem {
    func showChapter(_ index:Int) {
        content = mainConfigurator.chapter(index: index)
        
        let propertiesStoryboard = UIStoryboard.init(name: "Chapters", bundle: Bundle.main)
        let navigationController = propertiesStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.chapterMain)
        
        let arrayContent:NSArray = content!["pages"] as! NSArray
        let backgroundImageName = content!["backgroundName"] as! String
        
        (navigationController as! CarrouselChapterViewController).imagesArray = arrayContent
        (navigationController as! CarrouselChapterViewController).imageName = backgroundImageName
        (navigationController as! CarrouselChapterViewController).generalContent = content
        
        self.centerViewController = navigationController
    }
    
    func selectRightMenuItem(content: String!) {
        if content.contains("chapter"){
            let subString = content.replacingOccurrences(of: "chapter", with: "")
            guard let index = Int(subString) else {return}
            showChapter(index)
        }
        menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: nil)
    }
}
