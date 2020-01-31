//
//  OauthRequest.swift
//  myQiita-mvvm
//
//  Created by aimon on 2020/01/27.
//  Copyright © 2020 a.naga. All rights reserved.
//

import APIKit
import Himotoki

/** GET /api/v2/oauth/authorize
 *  APIアクセスするためのトークンを取得する
 *  https://qiita.com/api/v2/docs#get-apiv2oauthauthorize
 */
struct GetAuthorize: APIRequest {
    var authenticate: Bool = true

    typealias Response = [String]

    var method: HTTPMethod = .get
    var path: String { return "/api/v2/oauth/authorize" }
    ///登録されたAPIクライアントを特定するためのIDです。40桁の16進数で表現されます
    var clientId: String
    ///アプリケーションが利用するスコープをスペース区切りで指定できます
    var scope: String
    ///CSRF対策のため、認可後にリダイレクトするURLのクエリに含まれる値を指定できます
    //    var state: String

    var queryParameters: [String: Any]? {
        return [
            "client_id": clientId,
            "scope": scope
            //            "state": state
        ]
    }
    var parameters: Any? {
        return [
            "client_id": clientId,
            "scope": scope
            //            "state": state
        ]
    }

    init(clientId: String, scope: String) {
        self.clientId = clientId
        self.scope = scope
        //        self.state = state
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        print(object)
        print(urlResponse)

        //        return urlResponse
        return try decodeValue(object)
    }
}
