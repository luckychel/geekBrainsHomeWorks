//
//  FriendXIBTableViewCell.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 07.07.2022.
//

import UIKit

class FriendXIBTableViewCell: UITableViewCell {

    @IBOutlet var imageFriendXIB: UIImageView!
    
    @IBOutlet var nameFriendXIB: UILabel!
    
    @IBOutlet var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageFriendXIB.layer.cornerRadius = imageFriendXIB.bounds.width / 2
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        imageFriendXIB.isUserInteractionEnabled = true
        imageFriendXIB.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer){

        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.stiffness = 30
        animation.mass = 2
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        self.imageFriendXIB.layer.add(animation, forKey: nil)

    }
}
