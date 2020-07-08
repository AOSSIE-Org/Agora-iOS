//
//  DateFormat.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/9/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Date support isn't built in to SwiftyJSON
extension JSON {
    public var dateValue: Date? {
        get {
            if let str = self.string {
                return JSON.jsonDateFormatter.date(from: str)
            }
            return nil
        }
    }

    private static let jsonDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
        return dateFormatter
    }()
}

extension Date{
     func asString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
        return dateFormatter.string(from: self)
    }
}
