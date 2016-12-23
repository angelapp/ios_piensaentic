import UIKit

class Storage: NSObject {
    private var imageSelected:UIImage!
    private var metadata:AnyObject!
    
    static let shared = Storage()
    
    private override init() {
        super.init()
    }
    
    func setImage(image:UIImage!) -> () {
        guard image != nil else {return}
        self.imageSelected = image
    }
    
    func setMetadata(metadata:AnyObject!) -> () {
        guard metadata != nil else {return}
        self.metadata = metadata
    }
    
    func getImage() -> UIImage!{
        return imageSelected
    }
    
    func getMetadata() -> AnyObject!{
        return metadata
    }
}
