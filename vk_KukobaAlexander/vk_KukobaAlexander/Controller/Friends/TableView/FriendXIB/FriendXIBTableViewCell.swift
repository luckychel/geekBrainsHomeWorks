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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageFriendXIB.layer.cornerRadius = imageFriendXIB.bounds.width / 2
    }
}
