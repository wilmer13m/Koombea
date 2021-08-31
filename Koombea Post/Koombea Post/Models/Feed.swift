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
            guard let postInfoEntity = DatabaseHandler.shared.add(type: PostInfoEntity.self) else {return}

            postInfoEntity.name = name
            postInfoEntity.uid = uid
            postInfoEntity.email = email
            postInfoEntity.profile_pics = profilePic
            
            posts.forEach { (post) in
                guard let postEntity = DatabaseHandler.shared.add(type: PostEntity.self) else {return}
                postEntity.date = post.date
                postEntity.id = Int64(post.id ?? 0)
                postEntity.pics = post.pics
                postInfoEntity.addToPosts(postEntity)
            }
            
            DatabaseHandler.shared.save()
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

