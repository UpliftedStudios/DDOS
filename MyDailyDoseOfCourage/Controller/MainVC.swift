//
//  ViewController.swift
//  MyDailyDoseOfCourage
//
//  Created by Raphael M. Hidalgo on 6/12/18.
//  Copyright © 2018 UpliftedStudios. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var todayTitleLbl: UILabel!
    @IBOutlet weak var todayScriptureLbl: UILabel!
    
    @IBOutlet weak var tomorrowTitleLbl: UILabel!
    @IBOutlet weak var tomorrowScriptureLbl: UILabel!
    
    @IBOutlet weak var yesterdayTitleLbl: UILabel!
    @IBOutlet weak var yesterdayScriptureLbl: UILabel!
    
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var todayEntry: EntryData?
    var todayBodyData = ""
    var tomorrowBodyData = ""
    var yesterdayBodyData = ""
    var todayPrayerData = ""
    var tomorrowPrayerData = ""
    var yesterdayPrayerData = ""
    
    var menuShowing = true
    
    let formattedString = NSMutableAttributedString()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJsonData()
    }
    

    //MARK: BUTTON FUNCTIONS
    @IBAction func todayBtnPressed(_ sender: Any) {
            performSegue(withIdentifier: "todayBtnSegue", sender: nil)
    }
    @IBAction func tomorrowBtnPressed(_ sender: Any) {
            performSegue(withIdentifier: "tomorrowBtnSegue", sender: nil)
    }
    @IBAction func yesterdayBtnPressed(_ sender: Any) {
            performSegue(withIdentifier: "yesterdayBtnSegue", sender: nil)
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        
        if leadingConstraint.constant == CGFloat(0) {

            leadingConstraint.constant = -220

            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })

        } else if leadingConstraint.constant == CGFloat(-220) {
            leadingConstraint.constant = 0

            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func calendarBtnTapped(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        dateFormatter.dateFormat = "MMMM dd"
        print(dateFormatter.string(from: date))
        
        if segue.identifier == "todayBtnSegue" {
            
            let destination = segue.destination as! DetailVC
            destination.entryTitle = todayTitleLbl.text
            destination.entryScripture = todayScriptureLbl.text
            destination.entryBody = todayBodyData
            destination.entryPrayer = todayPrayerData
            destination.displayDate = dateFormatter.string(from: date)
            
        } else if segue.identifier == "tomorrowBtnSegue" {
            
            let destination = segue.destination as! DetailVC
            destination.entryTitle = tomorrowTitleLbl.text
            destination.entryScripture = tomorrowScriptureLbl.text
            destination.entryBody = tomorrowBodyData
            destination.entryPrayer = tomorrowPrayerData
            destination.displayDate = dateFormatter.string(from: tomorrow!)
            
        } else if segue.identifier == "yesterdayBtnSegue" {
            
            let destination = segue.destination as! DetailVC
            destination.entryTitle = yesterdayTitleLbl.text
            destination.entryScripture = yesterdayScriptureLbl.text
            destination.entryBody = yesterdayBodyData
            destination.entryPrayer = yesterdayPrayerData
            destination.displayDate = dateFormatter.string(from: yesterday!)

        } else if segue.identifier == "tfhSegue" {
            
            let vc = segue.destination as! WebVC
            vc.webUrl = tfhUrl
            
        } else if segue.identifier == "youtubeSegue" {
            
            let vc = segue.destination as! WebVC
            vc.webUrl = youtubeUrl
            
        } else if segue.identifier == "faecbookSegue" {
            
            let vc = segue.destination as! WebVC
            vc.webUrl = facebookUrl
            
        } else if segue.identifier == "popoverSegue" {
            
            let popoverViewController = segue.destination as! CalendarVC
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController?.delegate = self
        } else {
            return
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func sideMenuHandled() {
        leadingConstraint.constant = -220
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    //MARK: JSON FUNCTIONS
    func getJsonData() {
        guard let path = Bundle.main.path(forResource: "test", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            dateFormatter.dateFormat = "MMMM-dd"
            let todayString = dateFormatter.string(from: date)
            let tomorrowString = dateFormatter.string(from: tomorrow!)
            let yesterdayString = dateFormatter.string(from: yesterday!)
            
            guard let array = json as? [String: Any] else { return }
            guard let today = array["\(todayString)"] as? [String: String] else { return }
            guard let tomorrow = array["\(tomorrowString)"] as? [String: String] else { return }
            guard let yesterday = array["\(yesterdayString)"] as? [String: String] else { return }
            
            //MARK: JSON DATE ITEMS
            guard let todayTitle = today["title"] else { return }
            guard let todayScripture = today["scripture"] else { return }
            guard let todayBody = today["body"] else { return }
            guard let todayPrayer = today["prayer"] else { return }
            
            //Tomorrow
            guard let tomorrowTitle = tomorrow["title"] else { return }
            guard let tomorrowScripture = tomorrow["scripture"] else { return }
            guard let tomorrowBody = tomorrow["body"] else { return }
            guard let tomorrowPrayer = tomorrow["prayer"] else { return }
            
            //Yesterday
            guard let yesterdayTitle = yesterday["title"] else { return }
            guard let yesterdayScripture = yesterday["scripture"] else { return }
            guard let yesterdayBody = yesterday["body"] else { return }
            guard let yesterdayPrayer = yesterday["prayer"] else { return }
            
            //MARK: IMPLEMENT DATA
            todayTitleLbl.text = todayTitle
            todayScriptureLbl.text = todayScripture
            todayBodyData = todayBody
            todayPrayerData = todayPrayer
            
            tomorrowTitleLbl.text = tomorrowTitle
            tomorrowScriptureLbl.text = tomorrowScripture
            tomorrowBodyData = tomorrowBody
            tomorrowPrayerData = tomorrowPrayer
            
            yesterdayTitleLbl.text = yesterdayTitle
            yesterdayScriptureLbl.text = yesterdayScripture
            yesterdayBodyData = yesterdayBody
            yesterdayPrayerData = yesterdayPrayer
            
            print(todayString, tomorrowString, yesterdayString)
            
        } catch  {
            print(error)
        }
    }
}



