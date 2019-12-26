//
//  Item.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/10/16.
//  Copyright © 2019 a.naga. All rights reserved.
//

import APIKit
import Himotoki
import UIKit

struct Item: Himotoki.Decodable {
    var id: String
    var title: String
    var url: String
    var renderedBody: String
    var body: String
    var likesCount: Int
    var reactionsCount: Int
    var commentsCount: Int
    var pageViewsCount: Int?
    var isPrivate: Bool
    var isCoediting: Bool
    //    var group: Group
    var tags: [ItemTag]
    var user: User
    var createdAt: String
    var updatedAt: String

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
            tags: e <| "tags",
            user: e <| "user",
            createdAt: e <| "created_at",
            updatedAt: e <| "updated_at"
        )
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
