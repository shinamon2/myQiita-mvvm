//
//  String+Validator.swift
//  myQiita-mvvm
//
//  Created by aimon on 2020/01/31.
//  Copyright © 2020 a.naga. All rights reserved.
//

import Foundation

extension String {

    func isAlphanumeric() -> Bool {
        let pattern = "[^a-zA-Z0-9]+"   //TODO: 修正予定
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        if matches.count > 0 {
            return false
        } else {
            return true
        }

    }
}
