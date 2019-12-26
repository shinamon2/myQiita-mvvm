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
    struct Http {
        enum Url {
            static let timeoutInterval: TimeInterval = 20.0
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
