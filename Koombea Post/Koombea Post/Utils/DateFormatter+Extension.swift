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
        formatter.dateFormat = "yyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    static let showPostDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }()
}
