
extension UIView {
    func drawBorder(_ color:UIColor!, y: CGFloat, key:String!, dotted:Bool) -> Void{
        guard let layer:CALayer = self.layer.value(forKey: key) as! CALayer! else {
            startDrawBorder(color, y: y, key: key, dotted: dotted)
            return
        }
        if layer != nil {
           layer.removeFromSuperlayer()
        }
        
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

extension NSAttributedString {
    
    func stringWithWords(words:[String], fonts:[UIFont], color:UIColor) -> NSAttributedString{
        let string : NSMutableAttributedString = NSMutableAttributedString.init(string: "")
        for i in 0..<words.count {
            let word = words[i]
            let font: UIFont = fonts[i]
            let attributes = [NSFontAttributeName:font, NSForegroundColorAttributeName:color]
            let subString = NSAttributedString.init(string: word, attributes: attributes)
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
