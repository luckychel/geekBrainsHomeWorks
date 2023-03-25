//
//  CommentsCountControl.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 17.11.2022.
//

import UIKit

class CommentCountControl: UIControl {

    var newsItem: NewsItem!
    
    let commentButton = UIButton(frame: CGRect(x: 5, y: -3, width: 30, height: 30))
    let commentCount  = UILabel(frame: CGRect(x: 32, y: -3, width: 30, height: 30))

    func setCommentNewsControl(item : NewsItem, cellIndex: Int) {
        
        newsItem = item
        
        commentCount.text = String(newsItem.commentsCount)
        commentCount.font = commentCount.font.withSize(12)
        commentCount.textColor = .lightGray
        
        commentButton.setImage(UIImage(systemName: "text.bubble"), for: .normal)
      
        commentButton.tintColor = .lightGray
        
        addSubview(commentButton)
        addSubview(commentCount)
        
    }


}
