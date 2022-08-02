//
//  GroupXIBTableViewCell.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 07.07.2022.
//

import UIKit

class GroupXIBTableViewCell: UITableViewCell {
    
    @IBOutlet var groupNameXIB: UILabel!
    
    @IBOutlet var groupDescriptionXIB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
