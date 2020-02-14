//
//  StockItemDataStore.swift
//  myQiita-mvvm
//
//  Created by aimon on 2020/01/09.
//  Copyright © 2020 a.naga. All rights reserved.
//

import RealmSwift

class StockItemDataStore {

    static func getStockItem() -> Item? {
        let realm = try! Realm()
        return realm.objects(Item.self).last
    }

    static func update(item: Item) {
        let realm = try! Realm()
        if let oldUser = realm.objects(Item.self).filter("id < " + item.id).first {
            try! realm.write {
                realm.delete(oldUser)
                realm.add(item)
            }
        }
    }

    static func setList(items: [Item]) {
        let realm = try! Realm()
        for item in items {
            if realm.objects(Item.self).contains(where: { $0.id == item.id }) { continue }

            try! realm.write {
                realm.add(item)
            }
        }
    }

    static func getList(text: String) -> [Item]? {
        let realm = try! Realm()
        let searchText = text.lowercased()

        let result = realm.objects(Item.self).filter({ one -> Bool in

            if one.title.lowercased().contains(searchText) { return true }
            if one.body.lowercased().contains(searchText) { return true }

            guard let user = one.user else { return false }
            if user.name.lowercased().contains(searchText) { return true }

            guard let tags = one.tags else { return false }
            let filterTag = tags.filter { tag -> Bool in
                if tag.name.lowercased().contains(searchText) { return true }
                return false
            }
            if filterTag.count > 0 { return true }

            return false

        }).sorted { (item1, item2) -> Bool in
            item1.createdAt > item2.createdAt
        }
        return result
    }

}


