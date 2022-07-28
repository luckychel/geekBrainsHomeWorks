//
//  ViewNewsCounter.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 28.07.2022.
//

import UIKit

class ViewNewsCounter: UIView {
    

    var newsItem: News!
    
    let viewCount  = UILabel(frame: CGRect(x: 32, y: 0, width: 30, height: 30))
    let viewIcon = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    func setViewNewsCounter(news : News) {
        newsItem = news
        viewCount.text = String(news.likeCount)
        viewIcon.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        viewIcon.tintColor = .lightGray
        viewCount.textColor = .lightGray
        addSubview(viewIcon)
        addSubview(viewCount)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)

    }

    @objc func handleTap(_: UITapGestureRecognizer){
            newsItem.viewCount += 1
            setViewNewsCounter(news: newsItem)
        }
}
