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
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    let formattedString = NSMutableAttributedString()
    let newFormattedString = NSMutableAttributedString()
    
    var entryTitle: String?
    var entryScripture: String?
    var entryBody: String?
    var entryPrayer: String?
    var entryImage: UIImage?
    var entryDate: Date?
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
}
    
    @IBAction func yesterdayBtnTapped(_ sender: Any) {
        entryDate = Calendar.current.date(byAdding: .day, value: -1, to: entryDate!)
        print(dateFormatter.string(from: entryDate!))
        
        getJson()
    }
    
    @IBAction func tomorrowBtnTapped(_ sender: Any) {
        entryDate = Calendar.current.date(byAdding: .day, value: 1, to: entryDate!)
        print(dateFormatter.string(from: entryDate!))
        
        getJson()
        
    }
    
    func showData() {
        dateFormatter.dateFormat = "MMMM d"
        
        if  let displayTitle = entryTitle,
            let displayScripture = entryScripture,
            let displayBody = entryBody,
            let displayPrayer = entryPrayer,
            let displayDate = entryDate,
            let displayImage = entryImage {
            
            titleLbl.text = displayTitle
            titleLbl.sizeToFit()
            titleLbl.layoutIfNeeded()
            
            imageView.image = displayImage
            
            scriptureLbl.text = displayScripture
            scriptureLbl.sizeToFit()
            scriptureLbl.layoutIfNeeded()
            
            bodyLbl.text = displayBody
            bodyLbl.sizeToFit()
            bodyLbl.layoutIfNeeded()
            
            prayerLbl.text = displayPrayer
            prayerLbl.sizeToFit()
            prayerLbl.layoutIfNeeded()
            
            dateLbl.text = dateFormatter.string(from: displayDate)
        }
    }
    
    func getJson() {
        
        dateFormatter.dateFormat = "MMMM-dd"
        
        guard let path = Bundle.main.path(forResource: "test", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            let jsonDate = dateFormatter.string(from: entryDate!)
            
            guard let array = json as? [String: Any] else { return }
            guard let tomorrow = array["\(jsonDate)"] as? [String: String] else { return }
            
            //MARK: Tomorrow items
            guard let tomorrowTitle = tomorrow["title"] else { return }
            guard let tomorrowScripture = tomorrow["scripture"] else { return }
            guard let tomorrowBody = tomorrow["body"] else { return }
            guard let tomorrowPrayer = tomorrow["prayer"] else { return }
            guard let tomorrowImage = tomorrow["image"] else { return }


            titleLbl.text = tomorrowTitle
            scriptureLbl.text = tomorrowScripture
            bodyLbl.text = tomorrowBody
            prayerLbl.text = tomorrowPrayer
            imageView.image = UIImage(named: tomorrowImage)
            
            let noDashDateFormat = DateFormatter()
            noDashDateFormat.dateFormat = "MMMM d"
            let changingDate = noDashDateFormat.string(from: entryDate!)
            dateLbl.text = changingDate
            
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
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}

