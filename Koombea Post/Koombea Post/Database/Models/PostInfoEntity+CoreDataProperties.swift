//
//  PostInfoEntity+CoreDataProperties.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 31/8/21.
//
//

import Foundation
import CoreData


extension PostInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostInfoEntity> {
        return NSFetchRequest<PostInfoEntity>(entityName: "PostInfoEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var profile_pics: String?
    @NSManaged public var uid: String?
    @NSManaged public var posts: NSSet?

}

// MARK: Generated accessors for posts
extension PostInfoEntity {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: PostEntity)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: PostEntity)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}

extension PostInfoEntity : Identifiable {

}
