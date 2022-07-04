//
//  MyFriendTableViewCell.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 04.07.2022.
//

import UIKit

class MyFriendTableViewCell: UITableViewCell {

    @IBOutlet var imageFriend: UIImageView!
    
    @IBOutlet var nameFriend: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
