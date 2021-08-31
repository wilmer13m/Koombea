//
//  MockFeed.swift
//  Koombea PostTests
//
//  Created by Wilmer Mendoza on 31/8/21.
//

import Foundation
@testable import Koombea_Post

struct MockFeed {
    static let feed = Feed(data: [Feed.PostData(uid: "1",
                                                name: "wilmer",
                                                email: "email1@hotmail.com",
                                                profilePic: nil,
                                                posts: [Feed.PostData.Post(id: 1,
                                                                           date: "Tue Oct 12 2021 08:25:06 GMT-050",
                                                                           pics: ["somePics"])]),
                                  Feed.PostData(uid: "1",
                                                name: "Karen",
                                                email: "email2@hotmail.com",
                                                profilePic: nil,
                                                posts: [Feed.PostData.Post(id: 3,
                                                                           date: "Thu Mar 17 2022 08:25:06 GMT-050",
                                                                           pics: [""])])])
}
