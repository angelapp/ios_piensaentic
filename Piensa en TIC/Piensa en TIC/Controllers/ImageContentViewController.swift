//
//  ImageContentViewController.swift
//  Piensa en TIC
//
//  Created by SergioDan on 12/18/16.
//  Copyright © 2016 angelapp. All rights reserved.
//

import UIKit

class ImageContentViewController: GeneralViewController {

    @IBOutlet var topImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var rightImage: UIImageView!
    @IBOutlet var leftImage: UIImageView!

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
        guard let rightImageName = self.info["imageRight"] else {return}
        guard let leftImageName = self.info["imageLeft"] else {return}
        
        topImage.image = UIImage(named:topImageName)
        descriptionLabel.text = String(format: descriptionText, getUserNameFromUserDefaults())
        descriptionLabel.textColor = UIColor.init(hexString: colorText)
        
        rightImage.image = UIImage(named:rightImageName)
        leftImage.image = UIImage(named:leftImageName)
    }

    
}
