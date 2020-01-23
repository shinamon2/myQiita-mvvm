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
        guard let user = item.user else { return }
        self.userProfileImage.kf.setImage(with: ImageResource(downloadURL: URL(string: user.profileImageUrl)!))
        var userNeme = user.name
        if userNeme.isEmpty {
            userNeme = "@" + user.id
        }
        self.userNameButton.setTitle(userNeme, for: .normal)
        self.createdAtLavel.text = "が" + item.createdAt.trimAfterT() + "に投稿"

        self.likeCountLabel.text = String(item.likesCount)
        self.itemTitle.text = item.title

        guard let tags = item.tags else { tagsStackView.isHidden = true; return }
        tags.forEach { tag in
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
