//
//  SettingsVC.swift
//  MyDailyDoseOfCourage
//
//  Created by Marcus Hidalgo on 3/24/19.
//  Copyright © 2019 UpliftedStudios. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var dateField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func textFieldTapped(_ sender: Any) {
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        dateField.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector(("handleDatePicker")), for: .valueChanged)

    }
    
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h mm a"
        dateField.text = timeFormatter.string(from: sender.date)
    }
}
