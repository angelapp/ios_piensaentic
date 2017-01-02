import UIKit
import SwiftyJSON

class User: NSObject {
    var firstName:String!
    var nickName:String!
    var birthDate:String!
    var email:String!
    
    convenience init(_ firstName: String!, nickName: String!, birthDate: String!, email: String!) {
        self.init()
        self.firstName = firstName
        self.nickName = nickName
        self.birthDate = birthDate
        self.email = email
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encode(self.firstName as String, forKey:"firstName")
        aCoder.encode(self.nickName as String, forKey:"nickName")  // ERROR
        aCoder.encode(self.birthDate as String, forKey: "birthDate")
        aCoder.encode(self.email as String, forKey: "email")
    }
    
    func string() -> String {
        return "{" +
            "firstName:" + self.firstName + "," +
            "nickName:" + self.nickName + "," +
            "birthDate:" + self.birthDate + "," +
            "email:" + self.email + "," +
        "}"
    }
    
    func dictionary() -> [String:String] {
        var result = [String:String]()
        result["firstName"] = self.firstName
        result["nickName"] = self.nickName
        result["birthDate"] = self.birthDate
        result["email"] = self.email
        return result
    }
    
    class func initUser(fromDic dic: [String:String]) -> User {
        let user = User()
        user.firstName = dic["firstName"]
        user.nickName = dic["nickName"]
        user.birthDate = dic["birthDate"]
        user.email = dic["email"]
        return user
    }
}

extension User {
    class func archive(user: [String:String]) -> Data!{
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        
        return data
    }
    
    class func unarchive(data: Data) -> [String:String]! {
        guard let user = NSKeyedUnarchiver.unarchiveObject(with: data) as!  [String:String]! else {return nil}
        
        return user
    }
}
