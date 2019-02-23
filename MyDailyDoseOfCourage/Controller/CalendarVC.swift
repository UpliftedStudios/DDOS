//
//  CalendarVC.swift
//  MyDailyDoseOfCourage
//
//  Created by Marcus Hidalgo on 8/15/18.
//  Copyright © 2018 UpliftedStudios. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarVC: UIViewController {
    
    let formatter = DateFormatter()

    @IBOutlet weak var collectionView: JTAppleCalendarView!
    @IBOutlet weak var monthLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.scrollToDate( Date() )
        
        }
    
    func setupCalendarView() {
        collectionView.minimumLineSpacing = 0
        collectionView.minimumInteritemSpacing = 0
        
        collectionView.visibleDates { (visibleDates) in
            self.setupViewsFromCalendar(from: visibleDates)
        }
        
    }
    func setupViewsFromCalendar(from visibleDates: DateSegmentInfo) {
        let thisDate = visibleDates.monthDates.first!.date
        formatter.dateFormat = "MMMM"
        monthLbl.text = formatter.string(from: thisDate)
        
            }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CalendarCell else { return }

        if validCell.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CalendarCell else { return }
        
        if validCell.isSelected {
            validCell.dateLbl.textColor = UIColor.green
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLbl.textColor = UIColor.black
            } else {
                validCell.dateLbl.textColor = UIColor.gray
            }
        }
    }

}

extension CalendarVC: JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        return
    }

    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2018 01 01")!

        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
}

extension CalendarVC: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
        cell.dateLbl.text = cellState.text
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        //self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsFromCalendar(from: visibleDates)
    }
}
