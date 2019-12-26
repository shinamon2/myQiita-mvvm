//
//  StockItemTableViewCell.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/10/23.
//  Copyright © 2019 a.naga. All rights reserved.
//

import Kingfisher
import UIKit

class StockItemTableViewCell: UITableViewCell {

    @IBOutlet private weak var userProfileImage: UIImageView!
    @IBOutlet private weak var userNameButton: UIButton!
    @IBOutlet private weak var createdAtLavel: UILabel!
    @IBOutlet private weak var itemTitle: UILabel!
    @IBOutlet private weak var likeCountLabel: UILabel!
    @IBOutlet private weak var tagsStackView: UIStackView!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with item: Item) {
        self.userProfileImage.kf.setImage(with: ImageResource(downloadURL: URL(string: item.user.profileImageUrl)!))

        var userNeme = item.user.name
        if userNeme.isEmpty {
            userNeme = "@" + item.user.id
        }
        self.userNameButton.setTitle(userNeme, for: .normal)
        self.createdAtLavel.text = "が" + item.createdAt.trimAfterT() + "に投稿"

        self.likeCountLabel.text = String(item.likesCount)
        self.itemTitle.text = item.title

        if item.tags.count <= 0 { tagsStackView.isHidden = true; return }
        item.tags.forEach { tag in
            let label = UILabel()
            label.textColor = UIColor.white
            label.backgroundColor = UIColor.lightGray
            label.font = label.font.withSize(11)
            label.text = tag.name
            self.tagsStackView.addArrangedSubview(label)
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
