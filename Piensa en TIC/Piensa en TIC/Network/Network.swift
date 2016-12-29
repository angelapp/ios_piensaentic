import Alamofire

struct NetworkConstants {
    static let url = "https://piensaentic.co"
    static let api = "/api/"
    static let registerUserView = "register-user/"
    static let registerActivityFinishedView = "activity-register/"
}

class Network: NSObject {
    class func sendProgress(chapterIndex:Int) {
        let parameters: Parameters = [
            "foo": [1,2,3],
            "bar": [
                "baz": "qux"
            ]
        ]
        
        let url = [NetworkConstants.url, NetworkConstants.registerActivityFinishedView].flatMap{$0}.joined(separator: "")
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { (result) in
            guard let data = result.data, let utf8Text = String(data: data, encoding: .utf8) else {
                return
            }
            
            print(utf8Text)
        }
    }
}
