import Alamofire
import SwiftyJSON

struct NetworkConstants {
    static let url = "https://piensaentic.co"
    static let api = "/api/"
    static let registerUserView = "register-user/"
    static let registerActivityFinishedView = "activity-register/"
    static let passworRecoveryView = "password-recovery/"
    static let apiKey = "50134DF39-D02F-4EBD-34JK3-55KJK3-222JNM"
    static let headerApi = "APIID"
}

class Network: NSObject {
    class func setupRequest(_ url:String, parameters:[String:AnyObject]) -> URLRequest! {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(NetworkConstants.apiKey, forHTTPHeaderField: NetworkConstants.headerApi)
        let data = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        if let json = json {
            print(json)
        }
        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
        
        return request
    }
    
    class func getUser() -> User! {
        let storage = Storage.shared
        guard let data = storage.getParameterFromKey(key: .user) as! Data! else { return nil}
        guard let dic = User.unarchive(data: data) else { return nil}
        let user = User.initUser(fromDic: dic)
        return user
    }
    
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
    
    class func passwordRecovery(email: String){
        let storage = Storage.shared
        guard let savedEmail = storage.getParameterFromKey(key: .email) as! String! else { return nil}
        if savedEmail == email{
            guard let password = storage.getParameterFromKey(key: .password) as! String! else { return nil}
            let parameters: Parameters = [
                "user_mail":savedEmail, "password": password
            ]
            let url = [NetworkConstants.url,NetworkConstants.api, NetworkConstants.passworRecoveryView].flatMap{$0}.joined(separator: "")
            guard let request = setupRequest(url, parameters: parameters as [String : AnyObject]) else {return}
            Alamofire.request(request).debugLog().responseData { (result) in
                guard let data = result.data, let utf8Text = String(data: data, encoding: .utf8) else {
                    return
                }
                
                print("Response Server: ",utf8Text)
            }
            
        } else {
            showAlert(title: "Error", message: "Email no corresponde con el registrado en la aplicación.")
        }
    }
    
    class func sendProgress() {
        guard let result = getChapterList() else {return}
        guard let user = getUser() else {return}
        let parameters: Parameters = [
            "activities_register":result, "user_mail": user.email
        ]
        
        let url = [NetworkConstants.url,NetworkConstants.api, NetworkConstants.registerActivityFinishedView].flatMap{$0}.joined(separator: "")
        
        guard let request = setupRequest(url, parameters: parameters as [String : AnyObject]) else {return}
        
        Alamofire.request(request).debugLog().responseData { (result) in
            guard let data = result.data, let utf8Text = String(data: data, encoding: .utf8) else {
                return
            }
            
            print("Response Server: ",utf8Text)
        }
    }
    
    class func createUser(termsConditionalAccepted: Bool, completion: @escaping (ResponseCallback) -> ()){
        let storage = Storage.shared
        
        guard let data = storage.getParameterFromKey(key: .user) as! Data! else {
            completion(ResponseCallback.error(error: CustomError.NoData(description: "Error retrieving data")))
            return
        }
        
        guard let dic = User.unarchive(data: data) else {
            completion(ResponseCallback.error(error: CustomError.NoData(description: "Error retrieving data")))
            return
        }

        let user = User.initUser(fromDic: dic)
        
        let parameters: Parameters = [
            "first_name": user.firstName,
            "nick_name": user.nickName,
            "birthdate": user.birthDate,
            "email": user.email,
            "terms_conditions_accepted": termsConditionalAccepted
        ]
        
        let url = [NetworkConstants.url,NetworkConstants.api, NetworkConstants.registerUserView].flatMap{$0}.joined(separator: "")
        
        guard let request = setupRequest(url, parameters: parameters as [String:AnyObject]) else {
            completion(ResponseCallback.error(error: CustomError.NoData(description: "Error creating request")))
            return
        }
        
        Alamofire.request(request).debugLog().responseJSON { (dataResult) in
            guard dataResult.response != nil else {return}
            guard let data = dataResult.data, let utf8Text = String(data: data, encoding: .utf8) else {
                completion(ResponseCallback.error(error: CustomError.NoData(description: "Error parsing result")))
                return
            }
            
            guard let response = dataResult.response else {
                completion(ResponseCallback.error(error: CustomError.NoData(description: "Error response is nil")))
                return
            }
            
            let json = JSON(data: data)
            
            print("Response Server - create user: ",dataResult.response ?? "httpurlresponse nil")
            print("Response Server - create user: ",dataResult.result)
            print("Response Server - create user: ",data)
            print("Response Server - create user: ",utf8Text)
            print("Response Server - create user: ",json)
            
            var result:Bool = false
            
            switch response.statusCode {
                case 400:
                    break
                case 404:
                    break
                case 200:
                    storage.saveParameter(key: .email, value: json["email"].stringValue as AnyObject)
                    result = true
                    break
                default: break
            }
            
            completion(ResponseCallback.succeeded(succeeded: result))
        }
    }
}
