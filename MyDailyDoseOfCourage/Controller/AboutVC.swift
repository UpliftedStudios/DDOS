//
//  AboutVC.swift
//  MyDailyDoseOfCourage
//
//  Created by Marcus Hidalgo on 3/23/19.
//  Copyright © 2019 UpliftedStudios. All rights reserved.
//

import UIKit
import SideMenu

class AboutVC: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    let image = UIImage(named: "PE")
    let sideMenuVC = SideMenuVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.maskCircle(anyImage: image!)
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "baseline_menu_white_18pt_2x"), for: .normal)
        button.addTarget(self, action: #selector(menuBtnPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "About"
    }
    
    @objc func menuBtnPressed() {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
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
