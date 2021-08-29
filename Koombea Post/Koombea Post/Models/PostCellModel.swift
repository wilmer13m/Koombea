//
//  PostCellModel.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

struct PostCellModel {
    
    var posts: [PostCellModel.Post]
    
    init(postData: Feed.PostData) {
        
        posts = [PostCellModel.Post]()
        
        postData.posts.forEach { (post) in
            let post = Post(postImageUrl: post.pics ?? [],
                            datePost: ordinalDate(date: post.date ?? ""))
            self.posts.append(post)
        }
    }
    
    struct Post {
        let postImageUrl: [String]
        let datePost: String
    }
    
    func ordinalDate(date: String) -> String {
        
        guard let safeDate = Date(string: date, formatter: DateFormatter.originalPostDateFormatter) else { return "" }

        
        let ordinalFormatter = NumberFormatter()
        ordinalFormatter.numberStyle = .ordinal
        
        let day = Calendar.current.component(.day, from: safeDate)
        let dayOrdinal = ordinalFormatter.string(from: NSNumber(value: day))!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM '\(dayOrdinal)'"
        
        return dateFormatter.string(from: safeDate)
    }
}
