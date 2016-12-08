
import UIKit

struct MainConstants {
    static let chapters = "chapters"
    static let chapterPrefix = "chapter"
}

class MainConfigurator: NSObject {
    var configuration:String!
    var servicesKeys:NSDictionary!
    
    static let sharedConfiguration = MainConfigurator()
    
    private override init() {
        super.init()
        let mainBundle = Bundle.main
        guard let path = mainBundle.path(forResource: "Structure", ofType: "plist") else { return}
        guard let configurations = NSDictionary.init(contentsOfFile: path) else { return}
        guard let servicesKeys = configurations[MainConstants.chapters] as! NSDictionary! else { return}
        
        self.servicesKeys = servicesKeys as NSDictionary!
    }
    
    func chapter(index:Int) -> NSDictionary!{
        guard let servicesKeys = self.servicesKeys as NSDictionary! else { return nil}
        
        let identifier = [MainConstants.chapterPrefix,String(index)].flatMap{$0}.joined(separator: "")
        guard let content = servicesKeys[identifier] as! NSDictionary! else {return nil}
        return content
    }
    
    func countKeysByPrefix(_ content:NSDictionary,prefix:String)-> Int{
        
        let keysByPrefix = content.allKeys.filter { (r) -> Bool in
            (r as AnyObject).hasPrefix(prefix)
        }
        return keysByPrefix.count
    }
}
