
import UIKit

protocol CompleteChapterDelegate {
    func processChapter()
}

protocol SwipeDelegate {
    func backOnePage()
}

protocol DataSourceEnableSwipe {
    func enableSwipe()
    func disableSwipe()
}

class CarrouselChapterViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    @IBOutlet var contentView:UIView!
    @IBOutlet var backgroundImage:UIImageView!
    @IBOutlet var backgroundAlphaView: UIView!
    var pageViewController:UIPageViewController!
    var imagesArray:NSArray!
    var imageName:String!
    var generalContent:NSDictionary!
    var delegate:SelectRightMenuItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let imageName = imageName else { return}
        backgroundImage.image = UIImage(named:imageName)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup() {
//        imagesArray = [""]
        
        pageViewController = UIPageViewController.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        let startingViewController = self.viewController(index: 0, storyboard: self.storyboard!) as UIViewController
        let viewControllers = [startingViewController] as [UIViewController]!
        pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        self.addChildViewController(pageViewController)
        self.contentView.addSubview(self.pageViewController.view)
        
        let pageViewRect = self.contentView.bounds
        pageViewController.view.frame = pageViewRect
        pageViewController.didMove(toParentViewController: self)
        
        for subview in self.pageViewController.view.subviews {
            if subview.isKind(of: UIPageControl.self) {
                let pageControl = subview as! UIPageControl
                pageControl.pageIndicatorTintColor = UIColor(hexString:generalContent["pageIndicatorColorInactive"] as! String)
                pageControl.currentPageIndicatorTintColor = UIColor(hexString:generalContent["pageIndicatorColorActive"] as! String)
            }
        }
    }
    
    func viewController(index:Int, storyboard:UIStoryboard) -> GeneralViewController! {
        guard imagesArray.count >= 0 && index < imagesArray.count else { return nil }
        
        let content = imagesArray[index] as! [String:String]
        guard let identifier = content["content"] as String! else {return nil}
        
        if backgroundAlphaView != nil {
            backgroundAlphaView.isHidden = true
            backgroundAlphaView.backgroundColor = UIColor.clear
            
            if let backgroundAlphaColor = generalContent["backgroundAlphaColor"] as! String!,
                identifier != StoryboardIdentifier.introController,
                let activity = generalContent["menu_bullet_activity"] as! String!,
                activity == "vineta_cartera" {
                backgroundAlphaView.isHidden = false
                backgroundAlphaView.backgroundColor = UIColor(hexString: backgroundAlphaColor)
            }
        }
        
        if identifier == "surveyController" || identifier == "resultsController" {
            let temporalStoryboard = UIStoryboard.init(name: "ComplexScreens", bundle: nil)
            let viewController = temporalStoryboard.instantiateViewController(withIdentifier: identifier) as! GeneralViewController
            viewController.index = index
            viewController.info = content
            viewController.delegate = self
            viewController.delegateSwipe = self
            if let colorText = generalContent["textColor"] {
                viewController.colorText = colorText as! String
            }
            
            return viewController
        }
        
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! GeneralViewController
        viewController.index = index
        viewController.info = content
        viewController.delegate = self
        viewController.delegateSwipe = self
        if identifier == "previewController" {
            viewController.delegateTransition = self
        }
        if let colorText = generalContent["textColor"] {
            viewController.colorText = colorText as! String
        }
        if let activityName = generalContent["activity_name"] {
            viewController.activityName = activityName as! String
        }
        
        return viewController
    }
    
    func indexOf(viewController:GeneralViewController) -> Int!{
        guard let object = viewController.index else {return nil}
//        return imagesArray.index(where: { (index:Int) in
//            index == object
//        })!
        return object
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.indexOf(viewController: viewController as! GeneralViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard imagesArray.count > previousIndex else {
            return nil
        }
        
        return self.viewController(index: previousIndex, storyboard: self.storyboard!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.indexOf(viewController:viewController as! GeneralViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = imagesArray.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return self.viewController(index: nextIndex, storyboard: self.storyboard!)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return imagesArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        
        guard let controllers = pageViewController.viewControllers else {
            return UIPageViewControllerSpineLocation.min
        }
        let currentViewController = controllers[0]
        let viewControllers = [currentViewController]
        
        pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        return UIPageViewControllerSpineLocation.min
        
    }
}

extension CarrouselChapterViewController: CompleteChapterDelegate {
    func processChapter() {
        guard delegate != nil else {
            return
        }
        delegate.selectRightMenuItemAndSendProgress(content: "chapter0")
    }
}

extension CarrouselChapterViewController: DataSourceEnableSwipe {
    func enableSwipe() {
        for view in self.pageViewController!.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = true
            }
        }
    }
    
    func disableSwipe() {
        for view in self.pageViewController!.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
}

extension CarrouselChapterViewController: SwipeDelegate {
    func backOnePage() {
        guard let viewController =  viewController(index: 0, storyboard: storyboard!) else {return}
        self.pageViewController.setViewControllers([viewController], direction: .reverse, animated: true, completion: nil)
    }
}
