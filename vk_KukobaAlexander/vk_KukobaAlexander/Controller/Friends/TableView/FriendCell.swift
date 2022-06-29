//
//  FriendTableViewCell.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 26.06.2022.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet var imageFriend: UIImageView!
    
    @IBOutlet var nameFriend: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageFriend.layer.cornerRadius = imageFriend.bounds.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
