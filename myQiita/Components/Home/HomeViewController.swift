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
    @IBOutlet private weak var itemListTableView: UITableView!

    let viewModel: HomeViewModel
    let dataSource: HomeViewDataSource
    private let disposeBag = DisposeBag()

    required init?(coder aDecoder: NSCoder) {
        self.viewModel = HomeViewModel()
        self.dataSource = HomeViewDataSource(viewModel: viewModel)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.configure(with: itemListTableView)
        viewModel.loardTags()
        viewModel.loardStockItems()

        viewModel.tags.asDriver()
            .drive(onNext: { (tags) in
                if tags.count == 0 {return}

                print("----subscribe")
                print(tags)


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
    }

    private func showItem(url: String) {
        let vc = ItemWebViewController(url: url)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
