import UIKit

struct StorageConstants {
    static let imageName = "image"
    static let metadata = "metadata"
}

class Storage: NSObject {
    private var imageSelected:UIImage!
    private var metadata:AnyObject!
    var appState:UserDefaults!
    
    static let shared = Storage()
    
    private override init() {
        super.init()
        appState = UserDefaults.standard
    }
    
    func setImage(image:UIImage!) -> () {
        guard image != nil else {return}
        
        self.imageSelected = image
    }
    
    func getImage() -> UIImage! {
        return self.imageSelected
    }
    
    func setMetadata(metadata:AnyObject!) -> () {
        guard metadata != nil else {return}
        self.metadata = metadata
    }
    
    func getMetadata() -> AnyObject! {
        return self.metadata
    }
    
    func saveChapter(chapter:String) -> (){
        appState.set(true, forKey: chapter)
        appState.synchronize()
    }
    
    func getChapter(chapter:String) -> Bool{
        return appState.bool(forKey: chapter)
    }
    
    func saveOptionChosen(key:String, value:String){
        appState.set(value, forKey: key)
        appState.synchronize()
    }
    
    func saveParameter(key:Keys, value:AnyObject){
        appState.set(value, forKey: key.rawValue)
        appState.synchronize()
    }
    
    func getStringFromKey(key:String) -> String! {
        let result = appState.object(forKey: key) as! String!
        return result
    }
    
    func getParameterFromKey(key: Keys) -> AnyObject! {
        let result = appState.object(forKey: key.rawValue)
        return result as AnyObject!
    }
    
    func setToNil(key: Keys) {
        appState.setNilValueForKey(key.rawValue)
    }
    
    func saveChapter(_ key:String, value:Int) {
        appState.set(value, forKey: key)
    }
    
    func getIntFromKey(key:String) -> Int! {
        let result = appState.integer(forKey: key)
        return result
    }
}
