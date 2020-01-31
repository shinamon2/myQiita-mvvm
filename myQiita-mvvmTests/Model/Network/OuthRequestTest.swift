//
//  OuthRequestTest.swift
//  myQiita-mvvmTests
//
//  Created by aimon on 2020/01/29.
//  Copyright © 2020 a.naga. All rights reserved.
//

import APIKit
@testable import myQiita_mvvm
import XCTest

class OuthRequestTest: XCTestCase {

    var clientId = AppConfig.API.clientId

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print("test start!")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAuthorize() {
        var scope = AppConfig.API.Scope.readQiita
        print(scope)

        let request = GetAuthorize(clientId: clientId, scope: "read_qiita", state: "")
        Session.send(request) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure:
                print(result)
                break
            }
        }
    }
}
