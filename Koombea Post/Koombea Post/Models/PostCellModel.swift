//
//  PostCellModel.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

struct PostCellModel {
    
    var post: PostCellModel.Post
    
    init(postData: Feed.PostData.Post) {
        
        post = Post(postImageUrl: postData.pics ?? [],
                    datePost: postData.date?.ordinalDate() ?? "")
    }
    
    struct Post {
        let postImageUrl: [String]
        let datePost: String
    }
}
