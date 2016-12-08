
import UIKit

class CarrouselChapterViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    @IBOutlet var contentView:UIView!
    var pageViewController:UIPageViewController!
    var imagesArray:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
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
        
//        for subview in self.pageViewController.view.subviews {
//            if subview.isKind(of: UIPageControl.self) {
//                let pageControl = subview as! UIPageControl
//                pageControl.pageIndicatorTintColor = UIColor.lightGray
//                pageControl.currentPageIndicatorTintColor = UIColor.pageControlCustomColor()
//            }
//        }
    }
    
    func viewController(index:Int, storyboard:UIStoryboard) -> UIViewController! {
        guard imagesArray.count >= 0, index < imagesArray.count else { return nil }
        
        let viewController = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifier.viewStandard)
        
        return viewController
    }
    
    func indexOf(viewController:UIViewController) -> Int!{
//        guard let object = viewController.itemObject else {return nil}
//        return imagesArray.index(where: { (image:String) in
//            image == object
//        })!
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.indexOf(viewController: viewController) else {
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
        
        guard let viewControllerIndex = self.indexOf(viewController:viewController) else {
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
