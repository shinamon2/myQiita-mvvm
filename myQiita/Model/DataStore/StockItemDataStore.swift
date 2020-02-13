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
}


