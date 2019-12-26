//
//  APIRequest.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/09/25.
//  Copyright © 2019 a.naga. All rights reserved.
//

import APIKit
import Foundation
import Himotoki

protocol APIRequest: Request {
    var authenticate: Bool { get }
}
extension APIRequest {
    var authenticate: Bool { return true }
    var baseURL: URL { return URL(string: AppConfig.Http.Url.baseString)! }

    var accessToken: String? {
        //        let userDefaults = UserDefaults.standard
        //        return userDefaults.object(forKey: "accessToken") as? String
        return "635064edaa6e5673f3f0b7bfa9b701c66503add2"
    }

    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if authenticate {
            guard let accessToken = accessToken else { throw RequestError.invalidBaseURL(URL(string: AppConfig.Http.Url.baseString)!) }
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}

// GET /api/v2/tags
struct GetTags: APIRequest {
    typealias Response = [Tag]

    var method: HTTPMethod = .get
    var path: String { return "/api/v2/tags" }

    var page: String    //ページ番号 (1から100まで)
    var perPage: String //1ページあたりに含まれる要素数 (1から100まで)
    var sort: String    //並び順 (countで記事数順、nameで名前順)
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

//user_id = AncientBurialMound
//GET /api/v2/users/:user_id/stocks
//指定されたユーザがストックした記事一覧を、ストックした日時の降順で返します。
//https://qiita.com/api/v2/docs#get-apiv2usersuser_idstocks
struct GetStockItems: APIRequest {
    typealias Response = [Item]

    var method: HTTPMethod = .get
    var path: String { return "/api/v2/users/\(userId)/stocks" }

    let userId: String
    var page: String    //ページ番号 (1から100まで)
    var perPage: String //1ページあたりに含まれる要素数 (1から100まで)

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
