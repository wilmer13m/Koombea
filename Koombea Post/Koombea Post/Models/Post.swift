//
//  Post.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

struct PostResponse: Codable {
    
    var data: [Data]?
    
    struct Data: Codable {
        
        var uid: String?
        var name: String?
        var email: String?
        var profile_pic: String?
        var posts: [Post]
        
        struct Post: Codable {
            var id: Int?
            var date: String?
            var pics: [String]?
        }
    }
}
