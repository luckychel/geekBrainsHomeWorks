//
//  NewsViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 09.07.2022.
//

import UIKit

class NewsViewController: UIViewController {


    @IBOutlet var newsTable: UITableView!
    
    var news = [
        News(authorImage: UIImage(named: "gosha")!, authorName: "Георгий", dateCreate: Date.now, newsText: "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", newsImage: UIImage(named: "gosha")!, likeCount: 0, isLike: false, commentCount: 0, shareCount: 0, viewCount: 0),
        News(authorImage: UIImage(named: "ganna")!, authorName: "Жанна", dateCreate: Date.now, newsText: "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", newsImage: UIImage(named: "ganna")!, likeCount: 0, isLike: false, commentCount: 0, shareCount: 0, viewCount: 0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.newsTable.register(UINib(nibName: "NewsXIBTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsXIB")
        
        self.newsTable.dataSource = self
        self.newsTable.delegate = self
    }
    
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsXIB", for: indexPath) as! NewsXIBTableViewCell
        
        let content = cell

        //content.authorImageXIB.contentMode = .scaleAspectFill
        cell.authorImageXIB?.image = self.news[indexPath.row].authorImage
        cell.authorNameXIB.text = self.news[indexPath.row].authorName
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        cell.DateCreateXIB.text = dateFormatter.string(from: self.news[indexPath.row].dateCreate)
        cell.newsTextXIB.text = self.news[indexPath.row].newsText
        
        //cell.newsImageXIB.contentMode = .scaleAspectFill
        cell.newsImageXIB.image = self.news[indexPath.row].newsImage
        
        cell.contentConfiguration = content as? UIContentConfiguration
       
        cell.prepareForReuse()
        //cell.configure(newsItem: newsItem, cellIndex: indexPath.item)
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("News нажата строка № \(indexPath.row) в секции \(indexPath.section)")
        //performSegue(withIdentifier: "CollectionFriends", sender: indexPath)

    }
}
