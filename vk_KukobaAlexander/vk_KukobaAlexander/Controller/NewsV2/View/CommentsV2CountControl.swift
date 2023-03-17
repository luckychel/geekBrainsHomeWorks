//
//  CommentsCountControl.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 17.11.2022.
//

import UIKit

class CommentCountControl: UIControl {

    var newsItem: VKNewsItem!
    
    let commentCount  = UILabel(frame: CGRect(x: 32, y: 0, width: 30, height: 30))
    let commentButton = UIButton(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
    
    func setCommentNewsControl(item : VKNewsItem, cellIndex: Int) {
        
        newsItem = item
        let text: String = String(newsItem.comments?.count ?? 0)
        
        commentCount.text = text
        commentCount.textColor = .lightGray
        
        commentButton.setImage(UIImage(systemName: "text.bubble"), for: .normal)
        commentButton.tintColor = .lightGray
        
        addSubview(commentButton)
        addSubview(commentCount)
        
    }


}
