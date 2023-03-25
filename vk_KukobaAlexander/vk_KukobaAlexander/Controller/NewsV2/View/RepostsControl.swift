//
//  RepostsControl.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 25.03.2023.
//

import UIKit

class RepostsControl: UIControl {
    
    var newsItem: NewsItem!
    
    let repostButton = UIButton(frame: CGRect(x: 5, y: -1, width: 30, height: 30))
    let repostCount  = UILabel(frame: CGRect(x: 32, y: -1, width: 30, height: 30))

    func setRepostNewsControl(item : NewsItem, cellIndex: Int) {
        
        newsItem = item
        
        repostCount.text = String(newsItem.repostsCount)
        repostCount.font = repostCount.font.withSize(12)
        repostCount.textColor = .lightGray
        
        repostButton.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
      
        repostButton.tintColor = .lightGray
        
        addSubview(repostButton)
        addSubview(repostCount)
        
    }
}
