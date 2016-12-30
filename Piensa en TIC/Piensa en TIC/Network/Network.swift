import Alamofire

struct NetworkConstants {
    static let url = "https://piensaentic.co"
    static let api = "/api/"
    static let registerUserView = "register-user/"
    static let registerActivityFinishedView = "activity-register/"
}

class Network: NSObject {
    class func getChapterList() -> [[String:AnyObject]]! {
        guard let menu = MainConfigurator.sharedConfiguration.menuContent() else { return nil}
        let storage = Storage.shared
        var result = [[String:AnyObject]]()
        for dic in menu {
            let text = dic["text"] as! String
            if text.contains("Perfil") {
                continue
            }
            if let saved = storage.getIntFromKey(key: text) {
                if saved == 1 {
                    result.append(["activity_executed":text as AnyObject,
                               "execution_state":true as AnyObject])
                }
            }
        }
        
        return result
    }
    
    class func sendProgress() {
        guard let result = getChapterList() else {return}
        let parameters: Parameters = [
            "activities_register":[result], "user_man":"tic101@mail.co"
        ]
        
        let url = [NetworkConstants.url,NetworkConstants.api, NetworkConstants.registerActivityFinishedView].flatMap{$0}.joined(separator: "")
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).debugLog().responseData { (result) in
            guard let data = result.data, let utf8Text = String(data: data, encoding: .utf8) else {
                return
            }
            
            print("Response Server: ",utf8Text)
        }
    }
}
