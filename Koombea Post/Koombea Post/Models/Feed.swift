//
//  Post.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

struct Feed: Codable {
    
    var data: [PostData]?
    
    struct PostData: Codable {
        
        var uid: String?
        var name: String?
        var email: String?
        var profilePic: String?
        var posts: [Post]
        
        private enum CodingKeys: String, CodingKey {
            case uid, name, email, posts
            case profilePic = "profile_pic"
        }

        struct Post: Codable {
            var id: Int?
            var date: String?
            var pics: [String]?
        }
    }
}
