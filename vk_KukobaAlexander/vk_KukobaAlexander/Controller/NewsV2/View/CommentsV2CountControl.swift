//
//  CommentsCountControl.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 17.11.2022.
//

import UIKit

class CommentCountControl: UIControl {

    var newsItem: NewsV2!
    
    let commentCount  = UILabel(frame: CGRect(x: 32, y: 0, width: 30, height: 30))
    let commentButton = UIButton(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
    
    func setCommentNewsControl(item : NewsV2, cellIndex: Int) {
        
        newsItem = item
        
        commentCount.text = String((newsItem.commentCount))
        commentCount.textColor = .lightGray
        
        commentButton.setImage(UIImage(systemName: "text.bubble"), for: .normal)
        commentButton.tintColor = .lightGray
        
        addSubview(commentButton)
        addSubview(commentCount)
        
    }


}
