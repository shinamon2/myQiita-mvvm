//
//  myQiita_mvvmTests.swift
//  myQiita-mvvmTests
//
//  Created by aimon on 2019/09/25.
//  Copyright © 2019 a.naga. All rights reserved.
//

//@testable import myQiita_mvvm
//import RxCocoa
//import RxSwift
//import XCTest

//class MyQiitaMvvmTests: XCTestCase {

//    let disposeBag = DisposeBag()
//    let vm = HomeViewModel()
//    var resultSubject = PublishSubject<Any>()

//    override func setUp() {
// Put setup code here. This method is called before the invocation of each test method in the class.

//        vm.tags.asObservable()
//            .subscribe(onNext: { res in
//                if res.count > 0 {
//                    self.resultSubject.onNext(res.count)
//                }
//            }).disposed(by: disposeBag)
//
//        vm.stockItems.asObservable()
//            .subscribe(onNext: { res in
//                if res.count > 0 {
//                    self.resultSubject.onNext(res.count)
//                }
//            }).disposed(by: disposeBag)
//    }
//
//    override func tearDown() {
// Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testLoadTags() {
//        vm.loadTags()
//        resultSubject.asObserver().subscribe(onNext: { any in
//            let count = any as! Int
//            XCTAssertGreaterThan(0, count)
//        }).disposed(by: disposeBag)
//    }
//
//    func testLoadStockItems() {
//        vm.loardStockItems()
//        resultSubject.asObserver()
//            .subscribe(onNext: { any in
//                let count = any as! Int
//                XCTAssertGreaterThan(0, count)
//            })
//    }
//}
