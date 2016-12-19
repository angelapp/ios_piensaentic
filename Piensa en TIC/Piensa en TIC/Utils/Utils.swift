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
    
    func stringWithWords(words:[String], fonts:[UIFont]) -> NSAttributedString{
        let string : NSMutableAttributedString = NSMutableAttributedString.init(string: "")
        for i in 0..<words.count {
            let word = words[i]
            let font: UIFont = fonts[i]
            let attributes = [NSFontAttributeName:font]
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
