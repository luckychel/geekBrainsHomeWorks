//
//  Utilities.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 28.07.2022.
//

import Foundation
import UIKit

class Utilities {
    
    func StringToDate(_ dateStr: String) -> Date {
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return RFC3339DateFormatter.date(from: dateStr) ?? Date.now
    }
}
