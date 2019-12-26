//
//  Tag.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/10/07.
//  Copyright © 2019 a.naga. All rights reserved.
//

import APIKit
import Himotoki
import UIKit

struct Tag: Himotoki.Decodable {

    var id: String
    var followersCount: Int
    var iconUrl: String?
    var itemsCount: Int

    static func decode(_ e: Extractor) throws -> Tag {
        return try! Tag(
            id: e <| "id",
            followersCount: e <| "followers_count",
            iconUrl: e <|? "icon_url",
            itemsCount: e <| "items_count"
        )
    }
}
