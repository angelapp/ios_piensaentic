import UIKit

protocol DismissIntro {
    func dismiss()
}

class IntroCarrouselViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    @IBOutlet var contentView:UIView!
    @IBOutlet var backgroundImage:UIImageView!
    var pageViewController:UIPageViewController!
    var imageName:String!
    var pagesArray:[[String:String]]!
    var generalContent:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = Network.getUser() else {
            self.initialSetup()
            return
        }
        
        dismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let imageName = "actintro_fondo"
        backgroundImage.image = UIImage(named:imageName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup() {
        pagesArray = [[String:String]]()
        pagesArray.append(["top_image":"logo","description":"Atrévete a superar retos y dominar la tecnología con actividades útiles para enfrentar los riesgos digitales."])
        pagesArray.append(["top_image":"logo", "description":"Lleve tu propio diario digital y aprende consejos de seguridad navegando de forma segura.", "background":"intro_bot_comencemos"])
        
        
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
        
//        for subview in self.pageViewController.view.subviews {
//            if subview.isKind(of: UIPageControl.self) {
//                let pageControl = subview as! UIPageControl
//                pageControl.pageIndicatorTintColor = UIColor(hexString:generalContent["pageIndicatorColorInactive"] as! String)
//                pageControl.currentPageIndicatorTintColor = UIColor(hexString:generalContent["pageIndicatorColorActive"] as! String)
//            }
//        }
    }
    
    func viewController(index:Int, storyboard:UIStoryboard) -> UIViewController! {
        guard pagesArray.count >= 0 && index < pagesArray.count else { return nil }
        
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "introInfoController") as! IntroInformationViewController
        let content = pagesArray[index]
        viewController.index = index
        viewController.content = content
        viewController.delegate = self
        return viewController
    }
    
    func indexOf(viewController:IntroInformationViewController) -> Int!{
        guard let object = viewController.index else {return nil}

        return object
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.indexOf(viewController: viewController as! IntroInformationViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard pagesArray.count > previousIndex else {
            return nil
        }
        
        return self.viewController(index: previousIndex, storyboard: self.storyboard!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.indexOf(viewController:viewController as! IntroInformationViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = pagesArray.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return self.viewController(index: nextIndex, storyboard: self.storyboard!)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pagesArray.count
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

extension IntroCarrouselViewController: DismissIntro {
    func dismiss() {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        present(storyboard.instantiateInitialViewController()!, animated: false, completion: nil)
    }
}
