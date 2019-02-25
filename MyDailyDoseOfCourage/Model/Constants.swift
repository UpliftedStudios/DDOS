//
//  Constants.swift
//  MyDailyDoseOfCourage
//
//  Created by Raphael M. Hidalgo on 6/12/18.
//  Copyright © 2018 UpliftedStudios. All rights reserved.
//

import Foundation

// MARK: DATA STRUCTURE
class EntryData {
    
    var title: String
    var scripture: String
    var body: String
    
    init (title: String, scripture: String, body: String) {
        self.title = title
        self.scripture = scripture
        self.body = body
    }
}

// MARK: CONSTANT LINKS
let tfhUrl = "http://www.ethefathershouse.org/wp/"
let facebookUrl = "https://www.facebook.com/ETheFathersHouse"
let youtubeUrl = "https://www.youtube.com/channel/UCSGkrJKji21ak91LhKR8jRQ/videos"

// MARK: TIME RELATED OBJECTS
var today = ""
var tomorr = ""
var yester = ""
var tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
var yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
var dateFormatter = DateFormatter()

// MARK: CALENDAR OBJECTS
var calendar = Calendar.current
var day = calendar.component(.day, from: Date())
var weekday = calendar.component(.weekday, from: Date()) - 1
var month = calendar.component(.month, from: Date()) - 1


// MARK: CALENDAR DATA ARRAYS
var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
var daysOfMonth = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
var daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
var currentMonth = String()
var numberOfEmptyBox = Int() // the number of empty boxes at the start of the current month
var nextNumberOfEmptyBox = Int() //the same with above but with the next month
var previousNumberOfEmptyBox = 0 //the same with above with the previous month
var direction = 0 //=0 if we are at the current month, = 1 if we are in a future month, = -1 if we are in a past month
var positionIndex = 0 // here we will store the above vars of the empty boxes
var leapYearCounter = 2 //its 2 because the next time is in two years from 2018
var dayCounter = 0

