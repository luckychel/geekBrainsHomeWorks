//
//  AvatarUIView.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 29.06.2022.
//

import UIKit

class AvatarUIView: UIView {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var shadowView: UIView!
    
    var shadowColor = UIColor.black
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 7
        shadowView.layer.shadowOpacity = 0.8
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.layer.cornerRadius = bounds.height / 2
        shadowView.layer.cornerRadius = bounds.height / 2
        
    }
}
