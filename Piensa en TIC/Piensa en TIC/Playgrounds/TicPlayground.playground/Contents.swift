//: Playground - noun: a place where people can play

import UIKit

var str = "Contraseña:\n,Mshtscnell|12,16"


func split(text: String, by:String?)-> [AnyObject]! {
    
    guard text.characters.count > 0 else {return nil}
    guard let separator = by else {return nil}
    guard separator.characters.count > 0 else {return nil}
    var array = [String]()
    switch separator {
        case "|":
            array = text.characters.split{$0 == "|"}.map(String.init)
        break
        case ",":
            array = text.characters.split{$0 == ","}.map(String.init)
        break
    default:
        array = text.characters.split{$0 == "|"}.map(String.init)
        break
    }

    return array as [AnyObject]!
}

func examine() {
    
    let array = split(text: str, by:"|")
    guard let arrayResult = array else { return }
    
    let words = split(text: arrayResult[0] as! String, by: ",")
    let fonts = split(text: arrayResult[1] as! String, by: ",")
    guard let fontsResult = fonts else {return}
    for i in 0..<fontsResult.count {
        let fontSize = fontsResult[i] as! String
        let cast = Int(fontSize)
        UIFont.systemFont(ofSize: CGFloat(cast!))
    }
}



examine()
