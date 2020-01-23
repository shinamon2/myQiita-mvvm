//
//  Item.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/10/16.
//  Copyright © 2019 a.naga. All rights reserved.
//

import APIKit
import Himotoki
import Realm
import RealmSwift
import UIKit

final class Item: Object, Himotoki.Decodable {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var renderedBody: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var likesCount: Int = 0
    @objc dynamic var reactionsCount: Int = 0
    @objc dynamic var commentsCount: Int = 0
    @objc dynamic var pageViewsCount: Int = 0
    @objc dynamic var isPrivate: Bool = true
    @objc dynamic var isCoediting: Bool = true
    //    var group: Group
    var tags: [ItemTag]?
    @objc dynamic var tagsString: String = ""
    var user: User?
    @objc dynamic var userId: String = ""
    @objc dynamic var createdAt: String = ""
    @objc dynamic var updatedAt: String = ""

    static func decode(_ e: Extractor) throws -> Item {
        return try! Item(
            id: e <| "id",
            title: e <| "title",
            url: e <| "url",
            renderedBody: e <| "rendered_body",
            body: e <| "body",
            likesCount: e <| "likes_count",
            reactionsCount: e <| "reactions_count",
            commentsCount: e <| "comments_count",
            pageViewsCount: e <|? "page_views_count",
            isPrivate: e <| "private",
            isCoediting: e <| "coediting",
            tags: e <|? "tags",
            user: e <|? "user",
            createdAt: e <| "created_at",
            updatedAt: e <| "updated_at"
        )
    }

    convenience init(id: String, title: String, url: String, renderedBody: String, body: String,
                     likesCount: Int, reactionsCount: Int, commentsCount: Int, pageViewsCount: Int?, isPrivate: Bool,
                     isCoediting: Bool,
                     tags: [ItemTag]?, user: User?,
                     createdAt: String, updatedAt: String) {
        self.init()
        self.id = id
        self.title = title
        self.url = url
        self.renderedBody = renderedBody
        self.body = body
        self.likesCount = likesCount
        self.reactionsCount = reactionsCount
        self.commentsCount = commentsCount
        self.pageViewsCount = pageViewsCount ?? 0
        self.isPrivate = isPrivate
        self.isCoediting = isCoediting
        self.tags = tags
        self.user = user
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    //    required init() {
    //        fatalError("init() has not been implemented")
    //    }

    override static func primaryKey() -> String? {
        return "id"
    }

}

struct ItemTag: Himotoki.Decodable {
    var name: String
    var versions: [String]

    static func decode(_ e: Extractor) throws -> ItemTag {
        return try! ItemTag(
            name: e <| "name",
            versions: e <| "versions"
        )
    }
}
