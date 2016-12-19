//
//  TextDescriptionViewController.swift
//  Piensa en TIC
//
//  Created by SergioDan on 12/18/16.
//  Copyright © 2016 angelapp. All rights reserved.
//

import UIKit

class TextDescriptionViewController: GeneralViewController {

    @IBOutlet var topImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var exampleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initialSetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initialSetup(){
        guard let topImageName = self.info["top_image_name"] else { return}
        guard let descriptionText = self.info["description"] else { return}
        guard let imageName = self.info["image"] else {return}
        guard let example = self.info["example"] else {return}
        
        
        
        topImage.image = UIImage(named:topImageName)
        descriptionLabel.text = String(format: descriptionText)
        image.image = UIImage(named:imageName)
        exampleLabel.attributedText = processExample(example)
    }

    func processExample(_ example:String) -> NSAttributedString {
        let array = example.split(by: "|")
        guard let arrayResult = array else { return NSAttributedString()}
        let words = (arrayResult[0] as! String).split(by: ",")
        let fonts = (arrayResult[1] as! String).split(by: ",")
        guard let wordsResult = words else {return NSAttributedString()}
        guard let fontsResult = fonts else {return NSAttributedString()}
        var wordsResponse = [AnyObject]()
        for i in 0..<wordsResult.count {
            let word = wordsResult[i] as! String
            let newText = word.replacingOccurrences(of: "u015", with: "\n")
            
            wordsResponse.append(newText as AnyObject)
        }
        
        var fontsResponse = [AnyObject]()
        for i in 0..<fontsResult.count {
            let fontSize = fontsResult[i] as! String
            let cast = Int(fontSize)
            
            fontsResponse.append(UIFont.systemFont(ofSize: CGFloat(cast!)))
        }
        
        let result = NSAttributedString().stringWithWords(words: wordsResponse as! [String], fonts: fontsResponse as! [UIFont])
        return result
    }

}
