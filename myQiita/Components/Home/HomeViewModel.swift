//
//  HomeViewModel.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/09/20.
//  Copyright © 2019 a.naga. All rights reserved.
//

import APIKit
import Foundation
import RxCocoa
import RxSwift

import Himotoki

final class HomeViewModel {

    var tags = BehaviorRelay<[Tag]>(value: [])
    var stockItems = BehaviorRelay<[Item]>(value: [])
    var showItem = PublishSubject<String>()


    //TODO: API確認用
    func loardTags() {
        let request = GetTags(page: "1", perPage: "20", sort: "count")
        Session.send(request) { result in
            switch result {
            case .success(let response):
                self.tags.accept(response)
            case .failure:
                print(result)
                break
            }
        }
    }

    func loardStockItems() {
        let request = GetStockItems(userId: "AncientBurialMound", page: "1", perPage: "20")
        Session.send(request) { result in
            switch result {
            case .success(let response):
                self.stockItems.accept(response)
            case .failure:
                print("======= loardStockItems failure ============")
                print(result)
                break
            }
        }
    }
}
