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
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var contnue: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let topImageName = self.info["top_image_name"] else { return}
        guard let descriptionText = self.info["description"] else { return}
        guard let imageName = self.info["image"] else {return}
        guard let buttonText = self.info["button"] else {return}
        
        topImage.image = UIImage(named:topImageName)
        descriptionLabel.text = descriptionText
        descriptionImage.image = UIImage(named:imageName)
        contnue.setImage(UIImage(named:buttonText), for: UIControlState.normal)
        contnue.setImage(UIImage(named:buttonText), for: UIControlState.selected)
        contnue.setImage(UIImage(named:buttonText), for: UIControlState.highlighted)
    }
    
    func actionButton(sender:Any?) -> () {
        guard let segue = self.info["segue"] else {return}
        performSegue(withIdentifier: segue, sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
