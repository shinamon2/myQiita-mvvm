//
//  HomeViewDataSource.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/10/23.
//  Copyright © 2019 a.naga. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

final class HomeViewDataSource: NSObject {
    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self

        let nib = UINib(nibName: "StockItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "StockItemTableViewCell")
    }
}

extension HomeViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stockItems.value.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockItemTableViewCell.className, for: indexPath) as! StockItemTableViewCell
        let item = viewModel.stockItems.value[indexPath.row]
        cell.configure(with: item)
        print(cell.frame)
        return cell
    }
}

extension HomeViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let item = viewModel.stockItems.value[indexPath.row]
        viewModel.showItem.onNext(item.url)
    }
}

