//
//  UserDataStore.swift
//  myQiita-mvvm
//
//  Created by aimon on 2020/02/06.
//  Copyright © 2020 a.naga. All rights reserved.
//

import Foundation
import RealmSwift

class UserDataStore {
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

    static func getUser() -> User? {
        let realm = try! Realm()
        return realm.objects(User.self).last
    }

    static func setUser(user: User) {
        let realm = try! Realm()
        if let oldUser = realm.objects(User.self).last {
            try! realm.write {
                realm.delete(oldUser)
                realm.add(user)
            }
        }
    }
}
