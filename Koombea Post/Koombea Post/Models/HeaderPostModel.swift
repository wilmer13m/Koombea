//
//  HeaderPostModel.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 29/8/21.
//

import Foundation

struct HeaderPostModel {
    
    let avatarImageUrl: String
    let userName: String
    let email: String
    
    init(postData: Feed.PostData) {
        avatarImageUrl = postData.profilePic ?? ""
        userName = postData.name ?? ""
        email = postData.email ?? ""
    }
}
