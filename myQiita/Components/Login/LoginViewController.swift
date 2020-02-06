//
//  LoginViewController.swift
//  myQiita-mvvmTests
//
//  Created by aimon on 2020/01/31.
//  Copyright © 2020 a.naga. All rights reserved.
//

import APIKit
import RxSwift
import SVProgressHUD
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var apiTokenTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()

        //TODO: 確認用　後で消す
        self.apiTokenTextField.text = "635064edaa6e5673f3f0b7bfa9b701c66503add2"
    }

    private func bind() {

        loginButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                guard let apiToken = self?.apiTokenTextField.text else { return }
                self?.viewModel.validation(apiTokenText: apiToken)
                self?.viewModel.login(token: apiToken)

            }).disposed(by: disposeBag)

        viewModel.statusSubject.asObservable()
            .subscribe(onNext: { [weak self] viewStatus in
                switch viewStatus {
                case .loginSuccess :
                    self?.showHomeView()
                }

                }, onError: { error in
                    switch error.self {
                    case is SessionTaskError:
                        SVProgressHUD.showError(withStatus: error.localizedDescription)
                    default:
                        let error = error as! BaseError
                        SVProgressHUD.showError(withStatus: error.message)
                    }
            }).disposed(by: disposeBag)
    }

    private func showHomeView() {
        let storyboard = UIStoryboard(name: "HomeView", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController

        if self.navigationController == nil {
            let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            navigationController.show(homeViewController, sender: true)
        } else {
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
}

