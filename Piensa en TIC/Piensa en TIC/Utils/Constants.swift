struct Constants {
    static let patternPassword = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!$%@#£€*?&_]{6,}$"
}

enum Keys: String {
    case email = "email"
    case user = "user"
}

enum ResponseCallback {
    case succeeded(succeeded: Bool)
    case succeededObject(result: AnyObject)
    case error(error: Error?)
}

enum CustomError:Error {
    case NoData(description:String)
}
