//
//  Date.swift
//  Complete Tasks
//
//  Created by Vishal Patel on 24/09/14.
//  Copyright (c) 2014 Vishal Patel. All rights reserved.
//

import Foundation

class Date {
    
    class func from(#year:Int, month:Int, day:Int) -> NSDate {

        var dateComponents = NSDateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        var gregorian = NSCalendar(identifier: NSGregorianCalendar)!
        let date = gregorian.dateFromComponents(dateComponents)
        return date!
    }
    
    class func toString(#date:NSDate) -> String {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateStringFormatter.stringFromDate(date)
        
        return dateString
    }
}