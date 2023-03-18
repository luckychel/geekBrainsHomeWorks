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
    
    func configure(index: Int){
        //var url: String? = ""

        self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2
        self.avatar.contentMode = .scaleAspectFill
        self.avatar.clipsToBounds = true
        
//        Utilities().UrlToData(url: url) { res in
//            self.avatar.image = UIImage(data: res)
//        }
//
//        let timeResult = Double(news.items?[index].date ?? 0)
//            let date = Date(timeIntervalSince1970: timeResult)
//            let dateFormatter = DateFormatter()
//            dateFormatter.timeStyle = DateFormatter.Style.medium
//            dateFormatter.dateStyle = DateFormatter.Style.medium
//            dateFormatter.timeZone = .current
//            let localDate = dateFormatter.string(from: date)
//
//        self.date.text = localDate
    }
}
