//
//  CommentNewsControl.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 28.07.2022.
//

import UIKit

class CommentNewsControl: UIControl {

    var newsItem: News!
    
    let commentCount  = UILabel(frame: CGRect(x: 32, y: 0, width: 30, height: 30))
    let commentButton = UIButton(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
    
    func setCommentNewsControl(news : News, cellIndex: Int) {
        newsItem = news
        commentCount.text = String(news.commentCount)
        commentButton.setImage(UIImage(systemName: "text.bubble"), for: .normal)
        commentButton.tintColor = .lightGray
        commentCount.textColor = .lightGray
        addSubview(commentButton)
        addSubview(commentCount)
        
    }


}
