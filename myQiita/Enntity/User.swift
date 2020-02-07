//
//  User.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/10/22.
//  Copyright © 2019 a.naga. All rights reserved.
//

import APIKit
import Himotoki
import Realm
import RealmSwift
import UIKit

final class User: Object, Himotoki.Decodable {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var selfIntroduction: String?
    @objc dynamic var profileImageUrl: String = ""
    @objc dynamic var organization: String?
    @objc dynamic var location: String?
    @objc dynamic var websiteUrl: String?
    @objc dynamic var facebookId: String?
    @objc dynamic var linkedinId: String?
    @objc dynamic var githubLoginName: String?
    @objc dynamic var twitterScreenName: String?
    @objc dynamic var followeesCount: Int = 0
    @objc dynamic var followersCount: Int = 0
    @objc dynamic var itemsCount: Int = 0
    @objc dynamic var permanentId: Int = 0
    @objc dynamic var isTeamOnly: Bool = false

    static func decode(_ e: Extractor) throws -> User {
        return try! User(
            id: e <| "id",
            name: e <| "name",
            selfIntroduction: e <|? "description",
            profileImageUrl: e <| "profile_image_url",
            organization: e <|? "organization",
            location: e <|? "location",
            websiteUrl: e <|? "website_url",
            facebookId: e <|? "facebook_id",
            linkedinId: e <|? "linkedin_id",
            githubLoginName: e <|? "github_login_name",
            twitterScreenName: e <|? "twitter_screen_name",
            followeesCount: e <| "followees_count",
            followersCount: e <| "followers_count",
            itemsCount: e <| "items_count",
            permanentId: e <| "permanent_id",
            isTeamOnly: e <| "team_only"
        )
    }
    convenience init(id: String, name: String, selfIntroduction: String?, profileImageUrl: String, organization: String?,
                     location: String?, websiteUrl: String?, facebookId: String?, linkedinId: String?, githubLoginName: String?,
                     twitterScreenName: String?, followeesCount: Int, followersCount: Int, itemsCount: Int, permanentId: Int,
                     isTeamOnly: Bool) {
        self.init()
        self.id = id
        self.name = name
        self.selfIntroduction = selfIntroduction
        self.profileImageUrl = profileImageUrl
        self.organization = organization
        self.location = location
        self.websiteUrl = websiteUrl
        self.facebookId = facebookId
        self.linkedinId = linkedinId
        self.githubLoginName = githubLoginName
        self.twitterScreenName = twitterScreenName
        self.followeesCount = followeesCount
        self.followersCount = followersCount
        self.itemsCount = itemsCount
        self.permanentId = permanentId
        self.isTeamOnly = isTeamOnly
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}

