//
//  PostTableViewCell.swift
//  authSwiftKukobaProject
//
//  Created by Александр Кукоба on 30.10.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var postName: UILabel!
    @IBOutlet var postDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
