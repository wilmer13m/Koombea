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
    
    func formatterDatedString(fromFormat: DateFormatter, toFormat: DateFormatter) -> String? {
        
        let myDate = fromFormat.date(from: self)
        
        guard let secureDate = myDate else {
            return nil
        }
        
        return toFormat.string(from: secureDate)
    }
}

