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
        News(authorImage: UIImage(named: "gosha")!, authorName: "Георгий",
             dateCreate: Utilities().StringToDate("2022-07-20T16:39:57-08:00"), newsText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", newsImage: UIImage(named: "gosha")!, likeCount: 0, isLike: false, commentCount: 0, shareCount: 0, viewCount: 0),
        News(authorImage: UIImage(named: "ganna")!, authorName: "Жанна", dateCreate: Utilities().StringToDate("2022-07-19T17:52:44-08:00"), newsText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sollicitudin tempor id eu nisl nunc mi ipsum faucibus. Aliquam id diam maecenas ultricies mi eget mauris. Id volutpat lacus laoreet non curabitur gravida arcu ac tortor. Malesuada fames ac turpis egestas.", newsImage: UIImage(named: "ganna")!, likeCount: 0, isLike: false, commentCount: 0, shareCount: 0, viewCount: 0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Новости"
        
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
        
        cell.prepareForReuse()
        
        let content = cell
        content.authorImageXIB.contentMode = .scaleAspectFill
        cell.authorImageXIB?.image = self.news[indexPath.row].authorImage
        cell.authorNameXIB.text = self.news[indexPath.row].authorName
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        cell.DateCreateXIB.text = dateFormatter.string(from: self.news[indexPath.row].dateCreate)
        cell.newsTextXIB.text = self.news[indexPath.row].newsText
        
        cell.newsImageXIB.contentMode = .scaleAspectFill
        cell.newsImageXIB.image = self.news[indexPath.row].newsImage
        
        let newsItem  = news[indexPath.item]
        
        cell.configure(newsItem: newsItem, cellIndex: indexPath.item)
        
        cell.contentConfiguration = content as? UIContentConfiguration
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("News нажата строка № \(indexPath.row) в секции \(indexPath.section)")
        self.performSegue(withIdentifier: "ShowNewsItem", sender: nil)

    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowNewsItem",
           let destinationVC = segue.destination as? NewsItemViewController,
           let indexPath = newsTable.indexPathForSelectedRow {
            let newsItem = news[indexPath.item]
            destinationVC.title = "Запись"
            destinationVC.newsItem = newsItem
            newsTable.reloadData()
        }
    }
}
