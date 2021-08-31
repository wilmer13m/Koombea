//
//  PostEntity+CoreDataProperties.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 31/8/21.
//
//

import Foundation
import CoreData


extension PostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostEntity> {
        return NSFetchRequest<PostEntity>(entityName: "PostEntity")
    }

    @NSManaged public var date: String?
    @NSManaged public var id: Int64
    @NSManaged public var pics: [String]?
    @NSManaged public var postInfo: PostInfoEntity?

}

extension PostEntity : Identifiable {

}
