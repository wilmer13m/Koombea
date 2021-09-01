//
//  String+Extensionn.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

extension String {
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: (self), comment: "")
    }
    
    func ordinalDate() -> String {
        
        guard let safeDate = Date(string: self, formatter: DateFormatter.originalPostDateFormatter) else { return "" }

        
        let ordinalFormatter = NumberFormatter()
        ordinalFormatter.numberStyle = .ordinal
        ordinalFormatter.locale = Locale(identifier: "en_US")
        
        let day = Calendar.current.component(.day, from: safeDate)
        let dayOrdinal = ordinalFormatter.string(from: NSNumber(value: day))!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM '\(dayOrdinal)'"
        
        return dateFormatter.string(from: safeDate).firstUppercased
    }
}
