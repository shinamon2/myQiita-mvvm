//
//  User.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/10/22.
//  Copyright © 2019 a.naga. All rights reserved.
//

import APIKit
import Himotoki
import UIKit

struct User: Himotoki.Decodable {
    var id: String
    var name: String
    var description: String?
    var profileImageUrl: String
    var organization: String?
    var location: String?
    var websiteUrl: String?
    var facebookId: String?
    var linkedinId: String?
    var githubLoginName: String?
    var twitterScreenName: String?
    var followeesCount: Int
    var followersCount: Int
    var itemsCount: Int
    var permanentId: Int
    var isTeamOnly: Bool


    static func decode(_ e: Extractor) throws -> User {
        return try! User(
            id: e <| "id",
            name: e <| "name",
            description: e <|? "description",
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
}

