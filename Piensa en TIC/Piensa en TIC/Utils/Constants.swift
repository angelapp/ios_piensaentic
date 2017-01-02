struct Constants {
    static let patternPassword = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!$%@#£€*?&_]{6,}$"
}

enum Keys: String {
    case email = "email"
    case password = "password"
    case user = "user"
    
    //MARK: fields to fill
    case nameFriendOne = "friendNameOne"
    case nameFriendTwo = "friendNameTwo"
    case nickNameFriendOne = "friendNickNameOne"
    case nickNameFriendTwo = "friendNickNameTwo"
    
    case moreStuffWallet = "moreWallet"
    case moreStuffPhone = "morePhone"
    
    case spyPlateNumber = "plateNumber"
    
}

enum ResponseCallback {
    case succeeded(succeeded: Bool)
    case succeededObject(result: AnyObject)
    case error(error: Error?)
}

enum CustomError:Error {
    case NoData(description:String)
}
