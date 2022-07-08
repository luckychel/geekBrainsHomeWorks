//
//  LikeControl.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 29.06.2022.
//

import UIKit

class LikeControl: UIControl {
    @IBOutlet var likePicture: UIImageView!
    
    var islike: Bool = false
    
    override func awakeFromNib() {
        likePicture.backgroundColor = .none
        likePicture.tintColor = .gray
        likePicture.image = UIImage(systemName: "suit.heart")
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
