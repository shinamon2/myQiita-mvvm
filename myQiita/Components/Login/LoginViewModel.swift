//
//  LoginViewModel.swift
//  myQiita-mvvmTests
//
//  Created by aimon on 2020/01/31.
//  Copyright © 2020 a.naga. All rights reserved.
//

import APIKit
import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {

    var apiToken = BehaviorRelay<String>(value: "")
    var statusSubject = PublishSubject<LoginViewStatus>()

    enum LoginViewStatus {
        case loginSuccess
    }
    enum LoginViewError: BaseError {
        case noAlphanumericValidationError  //英数字でないValitationエラー
        var message: String {
            switch self {
            case .noAlphanumericValidationError:
                return "トークンは英数字で入力してください"
            }
        }
    }

    func login(token: String) {
        let request = GetAuthenticatedUser(token: token)
        Session.send(request) { result in
            switch result {
            case .success:
                UserDataStore.setApiToken(token: token)
                self.statusSubject.onNext(LoginViewStatus.loginSuccess)
                break
            case .failure(let error):
                UserDataStore.removeApiToken()
                self.statusSubject.onError(error)
                break
            }
        }
    }
    
    //TODO: API疎通NG
    func loardAuthorize() {
        var aa = AppConfig.API.Scope.readQiita.rawValue
        var bbbb = AppConfig.API.clientId

        var request = GetAuthorize(clientId: AppConfig.API.clientId, scope: AppConfig.API.Scope.readQiita.rawValue)
        //        request.authenticate = false
        Session.send(request) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print("======= GetAuthorize failure ============")
                print(error)
                break
            }
        }
    }
}

extension LoginViewModel {

    func validation(apiTokenText: String) {
        //半角英数字以外の文字が含まれる
        if !apiTokenText.isAlphanumeric() {
            self.statusSubject.onError(LoginViewError.noAlphanumericValidationError)
        }
    }
}
