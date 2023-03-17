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
    
    func UrlToImage(url: String?, complection: @escaping (UIImage) -> ()) {

        guard let url = url else { return }

        // Create Data Task
        let dataTask = URLSession.shared.dataTask(with: URL(string: url)!) { (data, _, _) in

            if let data = data {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    complection(UIImage(data: data)!)
                }
            }
        }

        // Start Data Task
        dataTask.resume()
    }
    
    func UrlToData(url: String?, complection: @escaping (Data) -> ()) {

        guard let url = url else { return }
        
        guard let url =  URL(string: url) else { return }
       
        // Create Data Task
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in

            if let data = data {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    complection(data)
                }
            }
        }

        // Start Data Task
        dataTask.resume()
    }
    
//    func UrlToImage(from url: String?, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        guard let url = url else { return }
//        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: completion).resume()
//    }
}
