//
//  DetailVC.swift
//  MyDailyDoseOfCourage
//
//  Created by Raphael M. Hidalgo on 6/13/18.
//  Copyright © 2018 UpliftedStudios. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scriptureLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet weak var prayerLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    let formattedString = NSMutableAttributedString()
    
    var entryTitle: String?
    var entryScripture: String?
    var entryBody: String?
    var entryPrayer: String?
    //var displayDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "MMMM dd"
        dateLbl.text = dateFormatter.string(from: date)
        
        if let displayTitle = entryTitle, let displayScripture = entryScripture, let displayBody = entryBody, let displayPrayer = entryPrayer {
            
            titleLbl.text = displayTitle
            titleLbl.sizeToFit()
            titleLbl.layoutIfNeeded()
            
            scriptureLbl.text = displayScripture
            scriptureLbl.sizeToFit()
            scriptureLbl.layoutIfNeeded()
            
            bodyLbl.text = displayBody
            bodyLbl.sizeToFit()
            bodyLbl.layoutIfNeeded()
            
            formattedString
                .bold("Let's pray - ")
                .italics("\(displayPrayer)")
            
            prayerLbl.attributedText = formattedString
            prayerLbl.sizeToFit()
            prayerLbl.layoutIfNeeded()
        }
}
    
    @IBAction func yesterdayBtnTapped(_ sender: Any) {
        

        self.loadView()
        
        guard let path = Bundle.main.path(forResource: "test", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            dateFormatter.dateFormat = "MMMM-dd"
            
            let yesterdayString = dateFormatter.string(from: yesterday!)
            //displayDate = yesterdayString
            
            guard let array = json as? [String: Any] else { return }
            guard let yesterday = array["\(yesterdayString)"] as? [String: String] else { return }
            
            //MARK: Yesterday items
            guard let yesterdayTitle = yesterday["title"] else { return }
            guard let yesterdayScripture = yesterday["scripture"] else { return }
            guard let yesterdayBody = yesterday["body"] else { return }
            guard let yesterdayPrayer = yesterday["prayer"] else { return }
            
            titleLbl.text = yesterdayTitle
            scriptureLbl.text = yesterdayScripture
            bodyLbl.text = yesterdayBody
            
            formattedString
                .bold("Let's pray - ")
                .italics("\(yesterdayPrayer)")
            
            prayerLbl.attributedText = formattedString
            
            //dateLbl.text = displayDate
            
            
        } catch  {
            print(error)
        }
    }
    
    @IBAction func tomorrowBtnTapped(_ sender: Any) {
        
        self.loadView()
        
        guard let path = Bundle.main.path(forResource: "test", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            dateFormatter.dateFormat = "MMMM-dd"
            
            let tomorrowString = dateFormatter.string(from: tomorrow!)
            print(tomorrowString)
            //displayDate = tomorrowString
            
            guard let array = json as? [String: Any] else { return }
            guard let tomorrow = array["\(tomorrowString)"] as? [String: String] else { return }
            
            //MARK: Tomorrow items
            guard let tomorrowTitle = tomorrow["title"] else { return }
            guard let tomorrowScripture = tomorrow["scripture"] else { return }
            guard let tomorrowBody = tomorrow["body"] else { return }
            guard let tomorrowPrayer = tomorrow["prayer"] else { return }

            
            titleLbl.text = tomorrowTitle
            scriptureLbl.text = tomorrowScripture
            bodyLbl.text = tomorrowBody
            prayerLbl.text = tomorrowPrayer
            //ateLbl.text = displayDate
            
        } catch  {
            print(error)
        }
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 16)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func italics(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.italicSystemFont(ofSize: 16)]
        let italicString = NSMutableAttributedString(string: text, attributes: attrs)
        append(italicString)
        
        return self
    }
}



































