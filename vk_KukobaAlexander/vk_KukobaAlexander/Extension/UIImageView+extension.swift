//
//  UIImageView+extension.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 17.03.2023.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(_ imageUrl: String) {

        // Проверка на URL
        guard let url =  URL(string: imageUrl) else {
            return
        }
       
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let imageData = cache.cachedResponse(for: request)?.data {
            self.image = UIImage(data: imageData)
        } else {
            // Create Data Task
            let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in

                guard let data = data, let response = response else {
                    print("error", error?.localizedDescription ?? "not localzedDescription")
                    return
                }
                
                let cacheResponce = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cacheResponce, for: request)
                
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }

            // Start Data Task
            dataTask.resume()
        }
    }
}
