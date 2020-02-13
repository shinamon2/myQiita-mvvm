//
//  APIRequest.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/09/25.
//  Copyright © 2019 a.naga. All rights reserved.
//

import APIKit
import Himotoki

protocol APIRequest: Request {
    var authenticate: Bool { get }
}
extension APIRequest {
    var authenticate: Bool { return true }
    var baseURL: URL { return URL(string: AppConfig.Http.Url.baseString)! }

    var accessToken: String? {
        return ApiTokenDataStore.getApiToken()
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
