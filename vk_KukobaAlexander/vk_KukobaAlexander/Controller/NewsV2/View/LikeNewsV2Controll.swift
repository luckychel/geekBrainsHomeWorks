//
//  LikeNesThreadControll.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 17.11.2022.
//

import UIKit

class LikeNewsThreadControl: UIControl{
    
    var newsItem: NewsItem!
    
    let likeButton = UIButton(frame: CGRect(x: 5, y: -1, width: 30, height: 30))
    let likeCount  = UILabel(frame: CGRect(x: 32, y: -1, width: 30, height: 30))
    
    func setLikeNewsControl(item : NewsItem, cellIndex: Int) {

        newsItem = item
        
        let text: String = String(item.likesCount)
        
        likeCount.text = text
        likeCount.font = likeCount.font.withSize(12)
        
        likeCount.textColor = item.viewsCount == 1 ? .systemRed : .lightGray
        likeCount.isUserInteractionEnabled = true
        
        setLikeButton(isLike: item.viewsCount)
        likeButton.isUserInteractionEnabled = false

        addSubview(likeButton)
        addSubview(likeCount)
    }
    
    func setLikeButton(isLike: Int) {
        if isLike != 0 {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .systemRed
        }
        else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .lightGray
        }
    }
}
