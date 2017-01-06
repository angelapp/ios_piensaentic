import Alamofire

enum BorderPosition {
    case Up
    case Down
    case Left
    case Right
    case AllSides
}

extension UIView {
    func drawBorder(_ color:UIColor!, y: CGFloat, key:String!, dotted:Bool) -> Void{
        guard let layer:CALayer = self.layer.value(forKey: key) as! CALayer! else {
            startDrawBorder(color, y: y, key: key, dotted: dotted)
            return
        }
//        if layer != nil {
           layer.removeFromSuperlayer()
//        }
        
        startDrawBorder(color, y: y, key: key, dotted: dotted)
    }
    
    private func startDrawBorder(_ color:UIColor!, y: CGFloat, key:String!, dotted:Bool){
        let newLayer = layerForMargin(y, color: color, dotted: dotted)
        self.layer.addSublayer(newLayer)
        self.layer.setValue(newLayer, forKey: key)
    }
    
    func layerForMargin(_ y:CGFloat, color:UIColor, dotted:Bool) -> CALayer {
        let shapeLayer:CAShapeLayer = CAShapeLayer.init()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.lineJoin = "round"
        
        if dotted {
            shapeLayer.lineDashPattern = [NSNumber.init(value: 2),NSNumber.init(value: 1)]
        }
        
        shapeLayer.anchorPoint = CGPoint.zero
        
        let path:CGMutablePath = CGMutablePath.init()
        path.move(to: CGPoint.init(x: 0, y: y))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: y))
            
        shapeLayer.path = path
            
        return shapeLayer
    }
}

extension UITextView {
    func drawSeparator(_ position:BorderPosition, color:UIColor, dotted: Bool)-> () {
        let line = CAShapeLayer.init()
        let linePath = UIBezierPath.init()
        
        var y1:CGFloat = 0.0
        var x1:CGFloat = 0.0
        var y2:CGFloat = 0.0
        var x2:CGFloat = 0.0
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        switch position {
        case .Up:
            y1 = 0.0
            x1 = 0.0
            y2 = 0.0
            x2 = width
            break
        case .Down:
            y1 = height
            x1 = 0.0
            y2 = height
            x2 = width
            break
        case .Left:
            y1 = 0.0
            x1 = 0.0
            y2 = height
            x2 = 0.0
            break
        case .Right:
            y1 = 0.0
            x1 = width
            y2 = height
            x2 = width
            break
        default:
            break
        }
        
        linePath.move(to: CGPoint(x: x1, y: y1))
        linePath.addLine(to: CGPoint(x: x2, y: y2))
        
        if dotted {
            line.lineDashPattern = [NSNumber(value: 3.0), NSNumber(value: 1.0)]
        }
        
        line.path = linePath.cgPath
        line.fillColor = nil
        line.opacity = 0.7
        line.strokeColor = color.cgColor
        
        self.layer.addSublayer(line)
    }

}

extension NSAttributedString {
    
    func stringWithWords(words:[String], fonts:[UIFont], color:UIColor) -> NSAttributedString{
        let string : NSMutableAttributedString = NSMutableAttributedString.init(string: "")
        for i in 0..<words.count {
            let word = words[i]
            let font: UIFont = fonts[i]
            let attributes = [NSFontAttributeName:font, NSForegroundColorAttributeName:color]
            let subString = NSAttributedString(string: word, attributes: attributes)
            string.append(subString)
        }
        return string
    }
    
    func stringWithWords(words:[String], colors:[UIColor]) -> NSAttributedString{
        let string : NSMutableAttributedString = NSMutableAttributedString.init(string: "")
        for i in 0..<words.count {
            let word = words[i]
            let color: UIColor = colors[i]
            let attributes = [NSForegroundColorAttributeName:color]
            let subString = NSAttributedString.init(string: word, attributes: attributes)
            string.append(subString)
        }
        return string
    }
    
    func stringWithWords(words:[String], links:[String], color:UIColor, font:UIFont!) -> NSAttributedString{
        let string : NSMutableAttributedString = NSMutableAttributedString.init(string: "")
        for i in 0..<words.count {
            let word = words[i]
            let link = links[i]
            var attributes = [NSLinkAttributeName:link,
                              NSForegroundColorAttributeName:color,
                              NSFontAttributeName:font ?? UIFont.systemFont(ofSize: 14.0)] as [String : Any]
            if link != " " {
                attributes[NSUnderlineStyleAttributeName] = NSNumber(value: NSUnderlineStyle.styleSingle.rawValue) as Any
            }
            let subString = NSAttributedString.init(string: word, attributes: attributes)
            string.append(subString)
        }
        return string
    }
    
    func stringWithWords(words:[String], links:[String], color:UIColor) -> NSAttributedString{
        let string : NSMutableAttributedString = NSMutableAttributedString.init(string: "")
        for i in 0..<words.count {
            let word = words[i]
            let link = links[i]
            let attributes = [NSLinkAttributeName:link, NSForegroundColorAttributeName:color,NSFontAttributeName:UIFont.systemFont(ofSize: 17.0)] as [String : Any]
            let subString = NSAttributedString.init(string: word, attributes: attributes)
            string.append(subString)
        }
        return string
    }
    
    func appendAttributedStringWithWords(attributedString:NSAttributedString, words:[String], colors:[UIColor]) -> NSAttributedString{
        let string : NSMutableAttributedString = NSMutableAttributedString.init(string: "")
        string.append(attributedString)
        for i in 0..<words.count {
            let word = words[i]
            let color: UIColor = colors[i]
            let attributes = [NSForegroundColorAttributeName:color]
            let subString = NSAttributedString.init(string: word, attributes: attributes)
            string.append(subString)
        }
        return string
    }
}

extension String {
    func split(by:String?)-> [AnyObject]! {
        
        guard self.characters.count > 0 else {return nil}
        guard let separator = by else {return nil}
        guard separator.characters.count > 0 else {return nil}
        var array = [String]()
        switch separator {
        case "|":
            array = self.characters.split{$0 == "|"}.map(String.init)
            break
        case ",":
            array = self.characters.split{$0 == ","}.map(String.init)
            break
        default:
            array = self.characters.split{$0 == "|"}.map(String.init)
            break
        }
        
        return array as [AnyObject]!
    }
    
    func concatenate(_ items: Any...)-> String{
        return (items as! [String]).flatMap{$0}.joined(separator: "")
    }
}

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }

    
    public static func colorFromCode(code: Int) -> UIColor {
        let red = CGFloat(((code & 0xFF0000) >> 16)) / 255
        let green = CGFloat(((code & 0xFF00) >> 8)) / 255
        let blue = CGFloat((code & 0xFF)) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}

//MARK: parsing html to attributedstring
extension NSAttributedString {
    class func parseHtml(_ rawHtml: NSString) -> NSAttributedString! {
        let format = "<span style=\"font-family: \("HelveticaNeue"); font-size: \(18.0)\">%@</span>" as NSString
        let modifiedHtml = NSString(format: format, rawHtml)
        let html = modifiedHtml.replacingOccurrences(of: "\\n", with: "</br>").replacingOccurrences(of: "\n", with: "</br>")
        
        let attributes = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                          NSCharacterEncodingDocumentAttribute: NSNumber(value: String.Encoding.utf8.rawValue),
                          NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 18.0) as Any] as [String : Any]
        
        do {
            guard let data = html.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) else { return NSAttributedString(string: html as String)}
            let result = try! NSAttributedString(data: data, options: attributes, documentAttributes: nil)
        
            return result
        } catch _ {
            return NSAttributedString(string: html, attributes: attributes)
        }
        
    }
}


//MARK: Request Alamofire enable logs
extension Request {
    public func debugLog() -> Self {
        #if DEBUG
            debugPrint(self)
        #endif
        return self
    }
}
