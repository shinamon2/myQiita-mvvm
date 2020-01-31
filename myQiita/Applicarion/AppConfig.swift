//
//  AppConfig.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/09/25.
//  Copyright © 2019 a.naga. All rights reserved.
//

import Foundation

struct AppConfig {
    static let version = "1.0"

    struct API {
        static let clientId: String = "84fa2a42b492fc10459946aa73c0f7f077bb58a4"
        enum Scope: String {
            case readQiita = "read_qiita"
            case readQiitaTeam = "read_qiita_team"
            case writeQiita = "write_qiita"
            case writeQiitaTeam = "write_qiita_team"
        }

    }
    struct Http {
        static let timeoutInterval: TimeInterval = 20.0
        enum Url {
            static let baseString: String = {
                #if RELEASE
                return "https://qiita.com"
                #else
                return "https://qiita.com"
                #endif
            }()
            static func imageURL(from string: String) -> URL? {
                #if RELEASE
                return URL(string: string)
                #else
                return URL(string: (AppConfig.Http.Url.baseString + string) )
                #endif
            }
        }
    }
}
