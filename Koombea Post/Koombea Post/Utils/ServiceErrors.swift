//
//  ServiceErros.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

enum ServiceErrors: String, Error {
    case invalidData = "Sorry. Somthing went wrong, try again"
    case invalidResponse = "Server error. Please modify your search and try again"
    case unknow = "unknow error..."
}
