//
//  Tag.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/10/07.
//  Copyright © 2019 a.naga. All rights reserved.
//

import APIKit
import Himotoki
import Realm
import RealmSwift
import UIKit

final class Tag: Object, Himotoki.Decodable {

    @objc dynamic var id: String = ""
    @objc dynamic var followersCount: Int = 0
    @objc dynamic var iconUrl: String?
    @objc dynamic var itemsCount: Int = 0

    static func decode(_ e: Extractor) throws -> Tag {
        return try! Tag(
            id: e <| "id",
            followersCount: e <| "followers_count",
            iconUrl: e <|? "icon_url",
            itemsCount: e <| "items_count"
        )
    }

    convenience init(id: String, followersCount: Int, iconUrl: String?, itemsCount: Int) {
        self.init()
        self.id = id
        self.followersCount = followersCount
        self.iconUrl = iconUrl
        self.itemsCount = itemsCount
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}
