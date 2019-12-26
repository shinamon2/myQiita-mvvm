//
//  NSObjectProtocol.extension.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/10/23.
//  Copyright © 2019 a.naga. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    static var className: String {
        return String(describing: self)
    }
}
