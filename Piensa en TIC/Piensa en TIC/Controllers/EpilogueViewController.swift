//
//  EpilogueViewController.swift
//  Piensa en TIC
//
//  Created by SergioDan on 12/16/16.
//  Copyright © 2016 angelapp. All rights reserved.
//

import UIKit

class EpilogueViewController: GeneralViewController {
    
    @IBOutlet var topImage: UIImageView!
    @IBOutlet var descriptionImage: UIImageView!
    @IBOutlet var descriptionLabel: UITextView!
    @IBOutlet var contnue: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let topImageName = self.info["top_image_name"] else { return}
        guard let descriptionText = self.info["description"] else { return}
        guard let imageName = self.info["image"] else {return}
        guard let buttonText = self.info["button"] else {return}
        
        topImage.image = UIImage(named:topImageName)
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = descriptionText
        descriptionImage.image = UIImage(named:imageName)
        descriptionLabel.textColor = UIColor.init(hexString: colorText)
        
        contnue.setBackgroundImage(UIImage(named:buttonText), for: UIControlState.normal)
        contnue.setBackgroundImage(UIImage(named:buttonText), for: UIControlState.selected)
        contnue.setBackgroundImage(UIImage(named:buttonText), for: UIControlState.highlighted)
        
        if let linksString = self.info["links"]{
            guard let links = linksString.split(by: ",") else {return}
            descriptionLabel.isSelectable = true
            descriptionLabel.attributedText = processDescriptionWithLinks(descriptionText, links: links as! [String])
            descriptionLabel.textAlignment = .center
        }
    }
    
    func actionButton(sender:Any?) -> () {
        guard let segue = self.info["segue"] else {return}
        performSegue(withIdentifier: segue, sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
