//
//  Date+Formatter.swift
//  
//
//  Created by Arthur Givigir on 07/04/23.
//

import Foundation

public extension Date {
   func getFormattedDate(format: DateFormattes) -> String {
        let dateformat = DateFormatter()
       dateformat.dateFormat = format.rawValue
        return dateformat.string(from: self)
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isNextDay: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
    
    var dateWithoutTime: Date {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
}

public enum DateFormattes: String {
    case full = "yyyy-MM-dd HH:mm:ss"
    case short = "dd/MM/yy"
    case withoutTime = "yyyy-MM-dd"
}
