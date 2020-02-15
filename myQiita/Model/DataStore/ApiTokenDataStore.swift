//
//  ApiTokenDataStore.swift
//  myQiita-mvvm
//
//  Created by aimon on 2020/02/13.
//  Copyright © 2020 a.naga. All rights reserved.
//

import Foundation

class ApiTokenDataStore {
    static let APITOKEN: String = "API_TOKEN"

    static func getApiToken() -> String? {
        return UserDefaults.standard.object(forKey: APITOKEN) as? String
    }

    static func setApiToken(token: String) {
        UserDefaults.standard.set(token, forKey: APITOKEN)
        UserDefaults.standard.synchronize()
    }

    static func removeApiToken() {
        UserDefaults.standard.removeObject(forKey: APITOKEN)
        UserDefaults.standard.synchronize()
    }

    static func haveApiToken() -> Bool {
        if getApiToken() == nil {
            return false
        } else {
            return true
        }
    }
}
