//
//  ServiceErros.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

enum ServiceErrors: String, Error {
    case invalidData = "com_koobea_post_invalid_data_error"
    case invalidResponse = "com_koobea_post_invalid_response_error"
    case unknow = "com_koobea_post_uknown_error"
}
