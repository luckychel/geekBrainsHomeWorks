//
//  News.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 09.07.2022.
//

import UIKit

class News {
    
    var authorImage: UIImage
    var authorName: String
    var dateCreate: Date
    var newsText: String
    var newsImage: UIImage
    var likeCount: Int = 0
    var isLike: Bool = false
    var commentCount: Int = 0
    var shareCount: Int = 0
    var viewCount: Int = 0
    
    init(authorImage: UIImage, authorName: String, dateCreate: Date, newsText: String, newsImage: UIImage){
        self.authorName = authorName
        self.authorImage = authorImage
        self.dateCreate = dateCreate
        self.newsImage = newsImage
        self.newsText = newsText
    }
    
    init(authorImage: UIImage, authorName: String, dateCreate: Date, newsText: String, newsImage: UIImage, likeCount: Int, isLike: Bool, commentCount: Int, shareCount: Int, viewCount: Int){
        self.authorName = authorName
        self.authorImage = authorImage
        self.dateCreate = dateCreate
        self.newsImage = newsImage
        self.newsText = newsText
        self.likeCount = likeCount
        self.isLike = isLike
        self.commentCount = commentCount
        self.shareCount = shareCount
        self.viewCount = viewCount
    }
}
