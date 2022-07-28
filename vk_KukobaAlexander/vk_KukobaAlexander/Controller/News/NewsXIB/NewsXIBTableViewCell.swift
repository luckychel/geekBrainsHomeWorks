//
//  NewsTableViewCell.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 09.07.2022.
//

import UIKit

class NewsXIBTableViewCell: UITableViewCell {

    @IBOutlet var authorImageXIB: UIImageView!
    
    @IBOutlet var authorNameXIB: UILabel!
    
    @IBOutlet var DateCreateXIB: UILabel!
    
    @IBOutlet var newsTextXIB: UILabel!
    
    @IBOutlet var newsImageXIB: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.authorImageXIB.layer.cornerRadius = self.authorImageXIB.bounds.width / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
