//
//  NewsTableViewCell.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 09.07.2022.
//

import UIKit

class NewsXIBTableViewCell: UITableViewCell {

    @IBOutlet var authorImageXIB: UIImageView!
    
    @IBOutlet var authorNameXIB: UILabel!
    
    @IBOutlet var DateCreateXIB: UILabel!
    
    @IBOutlet var newsTextXIB: UILabel!
    
    @IBOutlet var newsImageXIB: UIImageView!
    
    @IBOutlet var likeNews: LikeNewsControl!
    
    @IBOutlet var commentNews: CommentNewsControl!
    
    @IBOutlet var shareNews: ShareNewsControl!
    
    @IBOutlet var viewNews: ViewNewsCounter!

    @IBOutlet var controlView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.controlView.backgroundColor = .none
        self.authorImageXIB.layer.cornerRadius = self.authorImageXIB.bounds.width / 2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        likeNews.addGestureRecognizer(tap)
    }

    @objc func handleTap(_: UITapGestureRecognizer){
        
        if likeNews.newsItem.isLike {
            likeNews.newsItem.likeCount -= 1
            likeNews.likeCount.textColor = .lightGray
            animateLikeCountAppear()
        }
        else {
            likeNews.newsItem.likeCount += 1
            likeNews.likeCount.textColor = .systemRed
            animateLikeCountAppear()
            
            let groupAnimation = CAAnimationGroup()
            groupAnimation.beginTime = CACurrentMediaTime() + 0.5
            groupAnimation.duration = 0.5

            let scaleDown = CABasicAnimation(keyPath: "transform.scale")
            scaleDown.fromValue = 3.5
            scaleDown.toValue = 1.0
            let fade = CABasicAnimation(keyPath: "opacity")
            fade.fromValue = 0.0
            fade.toValue = 1.0

            groupAnimation.animations = [scaleDown,fade]
            likeNews.likeButton.layer.add(groupAnimation, forKey: nil)
        }
        likeNews.newsItem.isLike.toggle()
        likeNews.setLikeButton(isLike: likeNews.newsItem.isLike)
    }

    func animateLikeCountAppear(){
        UIView.transition(with: likeNews.likeCount,
                          duration: 0.5,
                          options: .transitionFlipFromRight) { [self] in
                    self.likeNews.likeCount.text = String(likeNews.newsItem.likeCount)
            }
    }
    
    func configure(newsItem: News, cellIndex: Int) {

        setControl(control: likeNews)
        self.likeNews.setLikeNewsControl(news: newsItem, cellIndex: cellIndex)
        setControl(control: commentNews)
        self.commentNews.setCommentNewsControl(news: newsItem, cellIndex: cellIndex)
        setControl(control: shareNews)
        self.shareNews.setShareNewsControl(news: newsItem, cellIndex: cellIndex)
        setControl(control: viewNews)
        self.viewNews.setViewNewsCounter(news: newsItem)
        
    }
    
    func setControl(control: UIControl){
        control.layer.cornerRadius = 15
        control.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
