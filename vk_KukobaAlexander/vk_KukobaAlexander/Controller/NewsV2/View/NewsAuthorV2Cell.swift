//
//  NewsAuthorDataTableViewCell.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 17.11.2022.
//

import UIKit

class NewsAuthorDataTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
