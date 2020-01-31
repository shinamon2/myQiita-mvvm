//
//  TagsRequest.swift
//  myQiita-mvvm
//
//  Created by aimon on 2020/01/27.
//  Copyright © 2020 a.naga. All rights reserved.
//

import APIKit
import Himotoki

/** GET /api/v2/tags
 *     タグ一覧を作成日時の降順で返します
 *     https://qiita.com/api/v2/docs#get-apiv2tags
 */
struct GetTags: APIRequest {
    var authenticate: Bool = true

    typealias Response = [Tag]

    var method: HTTPMethod = .get
    var path: String { return "/api/v2/tags" }
    ///ページ番号 (1から100まで)
    var page: String
    ///1ページあたりに含まれる要素数 (1から100まで)
    var perPage: String
    ///並び順 (countで記事数順、nameで名前順)
    var sort: String
    var parameters: Any? {
        return [
            "page": page,
            "per_page": perPage,
            "sort": sort
        ]
    }

    init(page: String, perPage: String, sort: String) {
        self.page = page
        self.perPage = perPage
        self.sort = sort
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try decodeValue(object)
    }
}
