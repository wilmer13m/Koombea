//
//  DateFormatter+Extension.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

extension DateFormatter {
    
    static let originalPostDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMMM d yyyy HH:mm:ss 'GMT'ZZZ"
        formatter.timeZone =  TimeZone(abbreviation: "GMT-4")
        return formatter
    }()
}
