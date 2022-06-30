//
//  FriendCollectionViewCell.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 28.06.2022.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageFriend: UIImageView!
    
    @IBOutlet var nameFriend: UILabel!
    
    
    
    @IBOutlet var likeControl: LikeControl!
    @IBOutlet var container: UIView!
    
    var cornerRadius: CGFloat = 5.0

        override func awakeFromNib() {
            super.awakeFromNib()
                
            // Apply rounded corners to contentView
            contentView.layer.cornerRadius = cornerRadius
            contentView.layer.masksToBounds = true
            
            // Set masks to bounds to false to avoid the shadow
            // from being clipped to the corner radius
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = false
            
            // Apply a shadow
            layer.shadowRadius = 8.0
            layer.shadowOpacity = 0.10
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 5)
            
            imageFriend.layer.cornerRadius = imageFriend.bounds.width / 6
            
            
            let tap = UITapGestureRecognizer(
                target: self, action: #selector(handleTap))
            tap.numberOfTapsRequired = 2
            container.addGestureRecognizer(tap)
            
        }
    
    @objc func handleTap(_: UITapGestureRecognizer) {
        likeControl.islike.toggle()
        
        if likeControl.islike {
            likeControl.likePicture.tintColor = .red
            likeControl.likePicture.image = UIImage(systemName: "suit.heart.fill")
        }
        else {
            likeControl.likePicture.tintColor = .gray
            likeControl.likePicture.image = UIImage(systemName: "suit.heart")
        }
    }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // Improve scrolling performance with an explicit shadowPath
            layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: cornerRadius
            ).cgPath
        }
    

    
}
