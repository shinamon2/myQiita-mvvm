//
//  UsersRequest.swift
//  myQiita-mvvm
//
//  Created by aimon on 2020/01/27.
//  Copyright © 2020 a.naga. All rights reserved.
//

import APIKit
import Himotoki

/** GET /api/v2/authenticated_user
 *     アクセストークンに紐付いたユーザを返します。
 *     https://qiita.com/api/v2/docs#get-apiv2authenticated_user
 */
struct GetAuthenticatedUser: APIRequest {
    typealias Response = User
    var method: HTTPMethod = .get
    var path: String { return "/api/v2/authenticated_user" }
    init(token: String?) {
        if let token = token {
            UserDataStore.setApiToken(token: token)
        }
    }
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try decodeValue(object)
    }
}

/** GET /api/v2/users/:user_id/stocks
 *     指定されたユーザがストックした記事一覧を、ストックした日時の降順で返します。
 *     https://qiita.com/api/v2/docs#get-apiv2usersuser_idstocks
 */
struct GetStockItems: APIRequest {
    typealias Response = [Item]
    var method: HTTPMethod = .get
    var path: String { return "/api/v2/users/\(userId)/stocks" }

    let userId: String
    ///ページ番号 (1から100まで)
    var page: String
    ///1ページあたりに含まれる要素数 (1から100まで)
    var perPage: String

    var parameters: Any? {
        return [
            "page": page,
            "per_page": perPage
        ]
    }

    init(userId: String, page: String, perPage: String) {
        self.userId = userId
        self.page = page
        self.perPage = perPage
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try decodeValue(object)
    }
}
