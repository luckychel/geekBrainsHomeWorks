//
//  LikeNesThreadControll.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 17.11.2022.
//

import UIKit

class LikeNewsThreadControl: UIControl{
    
    var newsItem: NewsV2!
    
    let likeButton = UIButton(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
    let likeCount  = UILabel(frame: CGRect(x: 32, y: 0, width: 50, height: 30))
    
    func setLikeNewsControl(item : NewsV2, cellIndex: Int) {
        
        newsItem = item
        
        likeCount.text = String((newsItem.likeCount))
        likeCount.textColor = newsItem.userLikes == 1 ? .systemRed : .lightGray
        likeCount.isUserInteractionEnabled = true
        
        setLikeButton(isLike: (newsItem.userLikes))
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
