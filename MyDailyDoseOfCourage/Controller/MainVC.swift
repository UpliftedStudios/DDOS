//
//  ViewController.swift
//  MyDailyDoseOfCourage
//
//  Created by Raphael M. Hidalgo on 6/12/18.
//  Copyright © 2018 UpliftedStudios. All rights reserved.
//

import UIKit
import SideMenu

class MainVC: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var todayTitleLbl: UILabel!
    @IBOutlet weak var todayImageView: UIImageView!

//    @IBOutlet weak var todayScriptureLbl: UILabel!
    
    @IBOutlet weak var tomorrowTitleLbl: UILabel!
    @IBOutlet weak var tomorrowImageView: UIImageView!

//    @IBOutlet weak var tomorrowScriptureLbl: UILabel!
    
    @IBOutlet weak var yesterdayTitleLbl: UILabel!
    @IBOutlet weak var yesterdayImageView: UIImageView!
    @IBOutlet weak var yesterdayScriptureLbl: UILabel!
    
    @IBOutlet weak var blurView: UIView!
    
    
    var todayEntry: EntryData?
    var todayBodyData = ""
    var todayScriptureData = ""
    var todayPrayerData = ""

    var tomorrowBodyData = ""
    var tomorrowScriptureData = ""
    var tomorrowPrayerData = ""

    var yesterdayBodyData = ""
    var yesteradayPrayerData = ""
    var yesterdayPrayerData = ""
    
    let formattedString = NSMutableAttributedString()

    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonData()
        
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "SideMenu") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        SideMenuManager.default.menuFadeStatusBar = false
        
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuShadowRadius = 10
        SideMenuManager.default.menuParallaxStrength = 10
//        SideMenuManager.default.menuAnimationFadeStrength = 0.5
//        SideMenuManager.default.menuShadowOpacity = 0.6

        
    }
    
    //MARK: BUTTON FUNCTIONS
    @IBAction func todayBtnPressed(_ sender: Any) {
            performSegue(withIdentifier: "todayBtnSegue", sender: nil) }
    @IBAction func tomorrowBtnPressed(_ sender: Any) {
            performSegue(withIdentifier: "tomorrowBtnSegue", sender: nil) }
    @IBAction func yesterdayBtnPressed(_ sender: Any) {
            performSegue(withIdentifier: "yesterdayBtnSegue", sender: nil) }
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        
        //To add blur effect
        if !UIAccessibility.isReduceTransparencyEnabled {
            blurView.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.blurView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            blurView.addSubview(blurEffectView)
            
        } else {
            blurView.backgroundColor = .clear
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "todayBtnSegue" {
            
            let destination = segue.destination as! DetailVC
            destination.entryTitle = todayTitleLbl.text
            destination.entryScripture = todayScriptureData
            destination.entryBody = todayBodyData
            destination.entryPrayer = todayPrayerData
            destination.entryDate = today
            destination.entryImage = todayImageView.image
            
        } else if segue.identifier == "tomorrowBtnSegue" {
            
            let destination = segue.destination as! DetailVC
            destination.entryTitle = tomorrowTitleLbl.text
            destination.entryScripture = tomorrowScriptureData
            destination.entryBody = tomorrowBodyData
            destination.entryPrayer = tomorrowPrayerData
            destination.entryDate = tomorrow
            destination.entryImage = tomorrowImageView.image
            
        } else if segue.identifier == "yesterdayBtnSegue" {
            
            let destination = segue.destination as! DetailVC
            destination.entryTitle = yesterdayTitleLbl.text
            destination.entryScripture = yesterdayScriptureLbl.text
            destination.entryBody = yesterdayBodyData
            destination.entryPrayer = yesterdayPrayerData
            destination.entryDate = yesterday
            destination.entryImage = yesterdayImageView.image

        } else if segue.identifier == "tfhSegue" {
            let vc = segue.destination as! WebVC
            vc.webUrl = tfhUrl
        } else if segue.identifier == "youtubeSegue" {
            let vc = segue.destination as! WebVC
            vc.webUrl = youtubeUrl
        } else if segue.identifier == "faecbookSegue" {
            let vc = segue.destination as! WebVC
            vc.webUrl = facebookUrl
            return
        }
    }
    
    //MARK: JSON FUNCTIONS
    func getJsonData() {
        guard let path = Bundle.main.path(forResource: "test", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        //print("test 1")
        
        do {
            //print("test 2")
            dateFormatter.dateFormat = "MMMM-dd"

            let data = try Data(contentsOf: url)
            //print("test 3")

            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            //print("test 4")

            guard let array = json as? [String: Any] else { return }
            //print("test 5")

            guard let today = array["\(dateFormatter.string(from: today))"] as? [String: String] else { return }

            guard let tomorrow = array["\(dateFormatter.string(from: tomorrow!))"] as? [String: String] else { return }
            //print("test 6")

            guard let yesterday = array["\(dateFormatter.string(from: yesterday!))"] as? [String: String] else { return }

            //MARK: JSON DATE ITEMS
            guard let todayTitle = today["title"] else { return }
            guard let todayScripture = today["scripture"] else { return }
            guard let todayBody = today["body"] else { return }
            guard let todayPrayer = today["prayer"] else { return }
            guard let todayImage = today["image"] else { return }
            
            //Tomorrow
            guard let tomorrowTitle = tomorrow["title"] else { return }
            guard let tomorrowScripture = tomorrow["scripture"] else { return }
            guard let tomorrowBody = tomorrow["body"] else { return }
            guard let tomorrowPrayer = tomorrow["prayer"] else { return }
            guard let tomorrowImage = tomorrow["image"] else { return }
            
            //Yesterday
            guard let yesterdayTitle = yesterday["title"] else { return }
            guard let yesterdayScripture = yesterday["scripture"] else { return }
            guard let yesterdayBody = yesterday["body"] else { return }
            guard let yesterdayPrayer = yesterday["prayer"] else { return }
            guard let yesterdayImage = yesterday["image"] else { return }
            
            //MARK: IMPLEMENT DATA
            todayTitleLbl.text = todayTitle
            todayScriptureData = todayScripture
            todayBodyData = todayBody
            todayPrayerData = todayPrayer
            todayImageView.image = UIImage(named: todayImage)

            tomorrowTitleLbl.text = tomorrowTitle
            tomorrowScriptureData = tomorrowScripture
            tomorrowBodyData = tomorrowBody
            tomorrowPrayerData = tomorrowPrayer
            tomorrowImageView.image = UIImage(named: tomorrowImage)

            yesterdayTitleLbl.text = yesterdayTitle
            yesterdayScriptureLbl.text = yesterdayScripture
            yesterdayBodyData = yesterdayBody
            yesterdayPrayerData = yesterdayPrayer
            yesterdayImageView.image = UIImage(named: yesterdayImage)
            
        } catch  {
            print(error)
        }
    }

//    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//        return UIModalPresentationStyle.none
//    }
}
    
//    Items and func to separate json get and show
//
//    var todayTitle = ""
//    var todayScripture = ""
//    var todayBody = ""
//    var todayPrayer = ""
//    var tomorrowTitle = ""
//    var tomorrowScripture = ""
//    var tomorrowBody = ""
//    var tomorrowPrayer = ""
//    var yesterdayTitle = ""
//    var yesterdayScripture = ""
//    var yesterdayBody = ""
//    var yesterdayPrayer = ""
//
//    func showJson (todayTitle: String,
//                   todayScripture: String,
//                   todayBody: String,
//                   todayPrayer: String,
//                   tomorrowTitle: String,
//                   tomorrowScripture: String,
//                   tomorrowBody: String,
//                   tomorrowPrayer: String,
//                   yesterdayTitle: String,
//                   yesterdayScripture: String,
//                   yesterdayBody: String,
//                   yesterdayPrayer: String) {
//
//        todayTitleLbl.text = todayTitle
//        todayScriptureLbl.text = todayScripture
//        todayBodyData = todayBody
//        todayPrayerData = todayPrayer
//
//        tomorrowTitleLbl.text = tomorrowTitle
//        tomorrowScriptureLbl.text = tomorrowScripture
//        tomorrowBodyData = tomorrowBody
//        tomorrowPrayerData = tomorrowPrayer
//
//        yesterdayTitleLbl.text = yesterdayTitle
//        yesterdayScriptureLbl.text = yesterdayScripture
//        yesterdayBodyData = yesterdayBody
//        yesterdayPrayerData = yesterdayPrayer
//    }
    




