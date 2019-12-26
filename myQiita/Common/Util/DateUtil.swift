//
//  DateUtil.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/12/21.
//  Copyright © 2019 a.naga. All rights reserved.
//

import Foundation


extension String {

    public func trimAfterT() -> String {
        return self.components(separatedBy: "T").first ?? ""
    }

    ///String ➝ 整形されたString
    public func getDateFormatted() -> String {
        let trimAfter = self.trimAfterT()
        if let date = dateFormatter.date(from: trimAfter) {
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
            let dateStr = dateFormatter.string(from: date).description
            return dateStr
        }
        return ""
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone = .current
    formatter.locale = Locale(identifier: "ja_JP")
    formatter.calendar = Calendar(identifier: .gregorian)
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

