//
//  StringProtocol+Extension.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 1/9/21.
//

import Foundation


extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}
