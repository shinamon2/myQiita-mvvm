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
        let homeViewController = UIStoryboard(name: "HomeView", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let myPageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController
        let tabBarController = UITabBarController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        tabBarController.setViewControllers([navigationController, myPageViewController], animated: true)
        UIApplication.shared.keyWindow?.rootViewController = tabBarController
    }
}

