//
//  LikeNesThreadControll.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 17.11.2022.
//

import UIKit

class LikeNewsThreadControl: UIControl{
    
    var newsItem: VKNewsItem!
    
    let likeButton = UIButton(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
    let likeCount  = UILabel(frame: CGRect(x: 32, y: 0, width: 50, height: 30))
    
    func setLikeNewsControl(item : VKNewsItem, cellIndex: Int) {
        
        newsItem = item
        
        let text: String = String((newsItem.likes?.count ?? 0))
        
        likeCount.text = text
        likeCount.textColor = newsItem.likes?.userLikes == 1 ? .systemRed : .lightGray
        likeCount.isUserInteractionEnabled = true
        
        setLikeButton(isLike: (newsItem.likes?.userLikes)!)
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
