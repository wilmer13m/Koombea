//
//  Post.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

struct Feed: Codable, Equatable {
    
    var identifier = UUID()
    var data: [PostData]?
    
    static let database = DatabaseHandler.shared
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
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

        func storeInDatabase() {
            guard let postEntity = Feed.database.add(type: PostEntity.self) else {return}
            postEntity.name = name
            postEntity.uid = uid
            postEntity.email = email
            postEntity.profile_pics = profilePic
            
            Feed.database.save()
        }
        struct Post: Codable {
            var id: Int?
            var date: String?
            var pics: [String]?
        }
    }
    
    static func == (lhs: Feed, rhs: Feed) -> Bool {
        lhs.identifier == rhs.identifier
    }
}
