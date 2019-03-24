//
//  AboutVC.swift
//  MyDailyDoseOfCourage
//
//  Created by Marcus Hidalgo on 3/23/19.
//  Copyright © 2019 UpliftedStudios. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "PE")
        photoImageView.maskCircle(anyImage: image!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tfhSegue" {
            let vc = segue.destination as! WebVC
            vc.webUrl = tfhUrl
        } else if segue.identifier == "youtubeSegue" {
            let vc = segue.destination as! WebVC
            vc.webUrl = youtubeUrl
        } else if segue.identifier == "facebookSegue" {
            let vc = segue.destination as! WebVC
            vc.webUrl = facebookUrl
        } else {
            return
        }
    }
    
    @IBAction func tfhWebBtnPressed(_ sender: Any) {
    }
    @IBAction func blogspotBtnPressed(_ sender: Any) {
    }
    @IBAction func facebookBtbPressed(_ sender: Any) {
    }
    @IBAction func youtubeBtnPressed(_ sender: Any) {
    }
}

extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        
        // make square(* must to make circle),
        // resize(reduce the kilobyte) and
        // fix rotation.
        self.image = anyImage
    }
}
