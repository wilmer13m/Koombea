//
//  EndPoints.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

struct EndPoints {
    
    private let apiName = "API MAIN URL"
    private let post = "users/posts"
    
    // MARK: Gets the full endpoint for end tracking
    func getPostURL() -> String {
        return getVariableFromPlist(variableName: apiName) + post
    }
    
    private func getVariableFromPlist(variableName: String) -> String {
        return ((Bundle.main.infoDictionary?[variableName] as? String)?.replacingOccurrences(of: "\\", with: ""))!
    }
}

