//
//  ViewsControl.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 25.03.2023.
//

import UIKit

class ViewsControl: UIControl {
    var newsItem: NewsItem!
    
    let viewsButton = UIButton(frame: CGRect(x: 2, y: -3, width: 30, height: 30))
    let viewsCount  = UILabel(frame: CGRect(x: 32, y: -3, width: 30, height: 30))

    func setViewsNewsControl(item : NewsItem, cellIndex: Int) {
        
        newsItem = item
        
        viewsCount.text = String(newsItem.viewsCount)
        viewsCount.font = viewsCount.font.withSize(12)
        viewsCount.textColor = .lightGray
        
        viewsButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
      
        viewsButton.tintColor = .lightGray
        
        addSubview(viewsButton)
        addSubview(viewsCount)
        
    }
}
