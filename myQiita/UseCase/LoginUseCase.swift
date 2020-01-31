//
//  LoginUseCase.swift
//  myQiita-mvvm
//
//  Created by aimon on 2020/01/31.
//  Copyright © 2020 a.naga. All rights reserved.
//

import Accounts
import Foundation
//import RxSwift
import RxCocoa

// MARK: - Interface
//public protocol LoginUseCase {
//    func haveApiToken() -> BehaviorRelay<Bool?>
//}

// MARK: - Implementation
//struct LoginUseCaseImpl: LoginUseCase {
//    let API_TOKEN: String = "API_TOKEN"
//
//
//    func haveApiToken() -> BehaviorRelay<Bool?> {
//
//        let aa = UserDefaults.standard.object(forKey: API_TOKEN)
//        if aa == nil {
//            return BehaviorRelay(value: fa)
//        }
//        return BehaviorRelay(value: true)
//    }
//}

class LoginUseCase {
    static let APITOKEN: String = "API_TOKEN"

    static func haveApiToken() -> Bool {
        if UserDefaults.standard.object(forKey: APITOKEN) == nil {
            return false
        } else {
            return true
        }
    }

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
}
