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
