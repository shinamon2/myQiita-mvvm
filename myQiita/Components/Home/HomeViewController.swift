//
//  HomeViewController.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/09/20.
//  Copyright © 2019 a.naga. All rights reserved.
//

import APIKit
import RxSwift
import UIKit
import WebKit

class HomeViewController: UIViewController {
    @IBOutlet private weak var itemListTableView: UITableView! {
        didSet {
            dataSource.configure(with: itemListTableView)
        }
    }
    @IBOutlet private weak var itemSearchBar: UISearchBar!
    let viewModel = HomeViewModel()
    let dataSource: HomeViewDataSource
    private let disposeBag = DisposeBag()

    required init?(coder aDecoder: NSCoder) {
        self.dataSource = HomeViewDataSource(viewModel: viewModel)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadStockItems()
        bind()
        setUI()
    }

    private func bind() {
        viewModel.tags.asDriver()
            .drive(onNext: { (tags) in
                if tags.count == 0 {return}
            }).disposed(by: disposeBag)

        viewModel.stockItems.asDriver()
            .skip(1)
            .drive(onNext: { stockItems in
                if stockItems.count == 0 {return}

                self.itemListTableView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.showItem
            .bind(onNext: showItem)
            .disposed(by: disposeBag)

        itemSearchBar.rx.text.asDriver()
            .skip(1)
            .drive(onNext: { text in
                guard let text = text else { return }
                self.viewModel.searchItem(text: text)
            }).disposed(by: disposeBag)
    }


    private func setUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(tapLogout))
        navigationItem.hidesBackButton = true

        self.itemSearchBar.placeholder = "絞り込みたい文字を入力してください"

    }

    private func showItem(url: String) {
        let vc = ItemWebViewController(url: url)
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func tapLogout() {
        UserDataStore.removeApiToken()
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let loginViewController = storyboard.instantiateInitialViewController() as! LoginViewController
        present(loginViewController, animated: true, completion: nil)
    }
}
