//
//  LikeNesThreadControll.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 17.11.2022.
//

import UIKit

class LikeNewsThreadControl: UIControl{
    
    var newsItem: VkNewsItem!
    
    let likeButton = UIButton(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
    let likeCount  = UILabel(frame: CGRect(x: 32, y: 0, width: 50, height: 30))
    
    func setLikeNewsControl(item : VkNewsItem, cellIndex: Int) {

        newsItem = item
        
        let text: String = String(item.likes?.count ?? 0)
        
        likeCount.text = text
        likeCount.textColor = item.likes?.userLikes ?? 0 == 1 ? .systemRed : .lightGray
        likeCount.isUserInteractionEnabled = true
        
        setLikeButton(isLike: item.likes?.userLikes ?? 0)
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
