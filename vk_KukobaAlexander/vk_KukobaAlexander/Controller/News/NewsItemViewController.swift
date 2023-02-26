//
//  NewsItemViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 29.07.2022.
//

import UIKit

class NewsItemViewController: UIViewController {

    var newsItem: News!
    
    @IBOutlet var NewsItemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.NewsItemTableView.register(UINib(nibName: "NewsXIBTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsXIB")
        
        self.NewsItemTableView.dataSource = self
        self.NewsItemTableView.delegate = self
    }
    

}
extension NewsItemViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsXIB", for: indexPath) as! NewsXIBTableViewCell
        
        cell.prepareForReuse()
        
        let content = cell
        content.authorImageXIB.contentMode = .scaleAspectFill
        cell.authorImageXIB.image = self.newsItem.authorImage
        cell.authorNameXIB.text = self.newsItem.authorName
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        cell.DateCreateXIB.text = dateFormatter.string(from: self.newsItem.dateCreate)
        cell.newsTextXIB.text = self.newsItem.newsText
        
        cell.newsImageXIB.contentMode = .scaleAspectFill
        cell.newsImageXIB.image = self.newsItem.newsImage
        
        cell.configure(newsItem: newsItem, cellIndex: indexPath.item)
        
        cell.contentConfiguration = content as? UIContentConfiguration

        return cell
    }
    

}
