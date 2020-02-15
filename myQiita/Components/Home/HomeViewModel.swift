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

    //    enum HomeViewStatus {
    //        case loadSuccess
    //        case reLoadSuccess
    //        case viewSuccess
    //    }

    enum HomeViewError: BaseError {
        case loadfailure
        var message: String {
            switch self {
            case .loadfailure:
                return "読み込みに失敗しました"
            }
        }
    }
    //TODO: API確認用
    func loadTags() {
        let request = GetTags(page: "1", perPage: "20", sort: "count")
        Session.send(request) { result in
            switch result {
            case .success(let response):
                self.tags.accept(response)
            case .failure:
                print(result)
            }
        }
    }

    func loadStockItems() {
        let request = GetStockItems(userId: "AncientBurialMound", page: "1", perPage: "100")
        Session.send(request) { result in
            switch result {
            case .success(let items):
                self.stockItems.accept(items)
                StockItemDataStore.setList(items: items)
            case .failure:
                print("======= loadStockItems failure ============")
                print(result)
                break
            }
        }
    }

    func searchItem(text: String) {
        guard let items = StockItemDataStore.getList(text: text) else { return }
        stockItems.accept(items)
    }
}
