import UIKit
import MFSideMenu
import Google

protocol SelectRightMenuItem {
    func selectRightMenuItem(content:String!)
    func selectRightMenuItemAndSendProgress(content:String!)
}

class HomeViewController: MFSideMenuContainerViewController {
    
    let mainConfigurator = MainConfigurator.sharedConfiguration
    var content:NSDictionary!
    var actualActivity: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.responds(to: #selector(getter: UIViewController.edgesForExtendedLayout)) {
            self.edgesForExtendedLayout = UIRectEdge.all
        }
        
        content = mainConfigurator.chapter(index: 0)
        actualActivity = content.object(forKey: "activity_name") as! String!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rightPanel()
        self.initialSetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Initial Setup
    func initialSetup() -> (){
        
        
        guard let nextChapter = getNextChapter() else {
            showPreface()
            return
        }
        if nextChapter.contains("chapter") {
            let chapterIndex = nextChapter.replacingOccurrences(of: "chapter", with: "")
            showChapter(Int(chapterIndex)!)
        } else {
            if nextChapter == "preface" {
                showPreface()
            } else {
                showCredits()
            }
        }

       
    
    }
    
    //MARK: setup right panel
    func rightPanel(){
        let homeStoryboard = UIStoryboard.init(name: "Menu", bundle: Bundle.main)
        let rightSideMenuViewController = homeStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.rightMenu)
        
        (rightSideMenuViewController as! RightViewController).delegate = self
        
        self.rightMenuViewController = rightSideMenuViewController
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
        actualActivity = content.object(forKey: "activity_name") as! String!
        sendActivityToAnalytics();
        
        let propertiesStoryboard = UIStoryboard.init(name: "Chapters", bundle: Bundle.main)
        let navigationController = propertiesStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.chapterMain)
        
        let arrayContent:NSArray = content!["pages"] as! NSArray
        let backgroundImageName = content!["backgroundName"] as! String
        
        if let menuColor = content["menuColor"] as! String! {
//            UINavigationBar.appearance().tintColor = UIColor(hexString: menuColor)
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hexString: menuColor)
            
        } else {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        }
        
        (navigationController as! CarrouselChapterViewController).imagesArray = arrayContent
        (navigationController as! CarrouselChapterViewController).imageName = backgroundImageName
        (navigationController as! CarrouselChapterViewController).generalContent = content
        (navigationController as! CarrouselChapterViewController).delegate = self
        
        self.centerViewController = navigationController
    }
    
    func showPreface() {
        content = mainConfigurator.preface()
        actualActivity = content.object(forKey: "activity_name") as! String!
        sendActivityToAnalytics();
        
        let propertiesStoryboard = UIStoryboard.init(name: "Profile", bundle: Bundle.main)
        let navigationController = propertiesStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.chapterMain)
        
        let arrayContent:NSArray = content!["pages"] as! NSArray
        let backgroundImageName = content!["backgroundName"] as! String
        
        (navigationController as! CarrouselChapterViewController).imagesArray = arrayContent
        (navigationController as! CarrouselChapterViewController).imageName = backgroundImageName
        (navigationController as! CarrouselChapterViewController).generalContent = content
        (navigationController as! CarrouselChapterViewController).delegate = self
        
        self.centerViewController = navigationController
    }
    
    func showCredits() {
        content = mainConfigurator.credits()
        actualActivity = content.object(forKey: "activity_name") as! String!
        sendActivityToAnalytics();
        
        let propertiesStoryboard = UIStoryboard.init(name: "Chapters", bundle: Bundle.main)
        let navigationController = propertiesStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.chapterMain)
        
        let arrayContent:NSArray = content!["pages"] as! NSArray
        let backgroundImageName = content!["backgroundName"] as! String
        
        if let menuColor = content["menuColor"] as! String! {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hexString: menuColor)
        } else {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        }
        
        (navigationController as! CarrouselChapterViewController).imagesArray = arrayContent
        (navigationController as! CarrouselChapterViewController).imageName = backgroundImageName
        (navigationController as! CarrouselChapterViewController).generalContent = content
        (navigationController as! CarrouselChapterViewController).delegate = self
        
        self.centerViewController = navigationController
    }

    
    func selectRightMenuItem(content: String!) {
        if content.contains("chapter"){
            let subString = content.replacingOccurrences(of: "chapter", with: "")
            guard let index = Int(subString) else {return}
            showChapter(index)
        } else if content.contains("preface") {
            showPreface()
        } else if content.contains("infocredits") {
            showCredits()
        }
        
        menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: nil)
    }
    
    func selectRightMenuItemAndSendProgress(content: String!) {
        Network.sendProgress()
        initialSetup()
    }
    
    
    func sendActivityToAnalytics(){
        if let default_tracker = GAI.sharedInstance().defaultTracker {
            print("default tracker " + actualActivity)
        }
        
        //let tracker = GAI.sharedInstance().defaultTracker
        let tracker = GAI.sharedInstance().tracker(withTrackingId: "UA-87589169-1")
        
        let event = GAIDictionaryBuilder.createEvent(withCategory: "Activity", action: "Activity Open", label: actualActivity, value: 0)
        tracker?.send(event!.build() as [NSObject: AnyObject])

    }
}

extension HomeViewController {
    func getNextChapter() -> String! {
        
        guard let menu = mainConfigurator.menuContent() else { return nil}
        guard let _ = Network.getUser() else {return "preface"}
        let storage = Storage.shared
        var result = "infocredits"
        for dic in menu {
            let text = dic["text"] as! String
            if text.contains("Perfil") {
                continue
            }
            if let saved = storage.getIntFromKey(key: text) {
                if saved == 0 {
                    result = dic["content"] as! String
                    break
                }
            }
        }
        
        guard let chapter = storage.getParameterFromKey(key: .latestChapter) as! String! , chapter.characters.count > 1 else {
            return result
        }
        storage.saveParameter(key: .latestChapter, value: "" as AnyObject)
        
        return chapter
    }
}
