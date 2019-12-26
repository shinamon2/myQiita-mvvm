//
//  __PREFIX__Presenter.swift
//  Kuri
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import Foundation
import RxSwift

enum __PREFIX__Status {
    case none
    case normal
    case notAuthorized
    case error
}

protocol __PREFIX__Presenter: class {
    func loadElements()
    func tapButton()
}


class __PREFIX__PresenterImpl: __PREFIX__Presenter {
    private weak var view: __PREFIX__View?
    private let wireframe: __PREFIX__Wireframe
    private let useCase: __PREFIX__UseCase
    
    fileprivate let observer: observer
    private let disposeBag = DisposeBag()
    
    public required init(
        view: __PREFIX__View,
        wireframe: __PREFIX__Wireframe,
        useCase: __PREFIX__UseCase,
        observer: SelectPersonObserver
        ) {
        self.view = view
        self.wireframe = wireframe
        self.useCase = useCase
        self.observer = observer
    }
    
    func loadElements() {
        useCase.loadElements()
            .subscribe(
                onNext: { [weak self] elements in
                    //加工してViewにセットしたりする処理
                    loadedelements(elements: elements)
                }, onError: { [weak self] error in
                    self?.errorHandling(error: error)
                }, onCompleted: nil, onDisposed: nil)
            ..disposed(by: disposeBag)
    }
}

// MARK: Private
extension __PREFIX__PresenterImpl {
    
    fileprivate func loadedelements(elements: Any) {
        DispatchQueue.main.async { [weak self] in
            //実際Viewにセットする部分
            self?.view?.setElement(accounts)
            self?.view?.changedStatus(__PREFIX__Status.normal)
            
//            self?.wireframe?.closeView()
//            observer.selectPersonObserver.onNext()
        }
    }
    
    fileprivate func errorHandling(error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let error = error as? AppError else {
                self?.view?.changedStatus(__PREFIX__Status.error)
                return
            }
            switch error {
            case .notAuthorized:
                self?.viewInput?.changedStatus(LoginAccountStatus.notAuthorized)
            default:
                self?.viewInput?.changedStatus(LoginAccountStatus.error)
            }
        }
    }
}

