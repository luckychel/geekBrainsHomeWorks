//
//  NewsV2ViewController.swift
//  VKontakte
//
//  Created by Александр Кукоба on 17.11.2022.
//

import UIKit

class NewsV2ViewController: BaseUIViewController {

    let session = Session.shared
    let vkApi = VKApi.shared
    
    @IBOutlet weak var newsTable: UITableView!
   
    var newsAll = [VKNews]()
    var news = [VKNewsItem]()
    
    private var photoService: PhotoService?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTable.dataSource = self
        newsTable.delegate = self

        photoService = PhotoService(container: newsTable)
        
        vkApi.getNews(token: session.token, id: session.userId) { res in
            
            //guard res.response?.items?.count ?? 0 > 0  else {return}
            guard let response = res.response else { return }
            
            self.newsAll.append(response)
            self.news = response.items!
            
            self.newsTable.reloadData()
        }
    }
    

}

extension NewsV2ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard news.count > 0 else { return 0 }
        guard (news[section].attachments?.contains(where: { $0.type == .photo})) != nil
                && news[section].text != "" else { return 2 }
        guard (news[section].attachments?.contains(where: { $0.type == .photo})) != nil
                || news[section].text != "" else { return 3 }
        return 4

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("Прорисовка секции новости \(indexPath.section)")
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsAuthor", for: indexPath) as! NewsAuthorDataTableViewCell
            
            cell.configure(index: indexPath.section, news: self.newsAll[indexPath.row])
             
           return cell
            
        case 1:

            if news[indexPath.section].text != "" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextTableViewCell
                cell.newsText.text = news[indexPath.section].text
                return cell
            } else {
                if news[indexPath.section].attachments != nil
                    && news[indexPath.section].attachments?.contains(where: { $0.type == .photo}) != nil {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoTableViewCell", for: indexPath) as! NewsPhotoTableViewCell
                        return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikeCommentsCell", for: indexPath) as! NewsLikeCommentsTableViewCell

                    let newsItem  = news[indexPath.section]

                    cell.configure(newsItem: newsItem, cellIndex: indexPath.section)

                    return cell
                }
            }
        case 2:
            if news[indexPath.section].attachments != nil
                && news[indexPath.section].attachments?.contains(where: { $0.type == .photo}) != nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoTableViewCell", for: indexPath) as! NewsPhotoTableViewCell
                    return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikeCommentsCell", for: indexPath) as! NewsLikeCommentsTableViewCell
                
                let newsItem  = news[indexPath.section]

                cell.configure(newsItem: newsItem, cellIndex: indexPath.section)

                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikeCommentsCell", for: indexPath) as! NewsLikeCommentsTableViewCell
            print(indexPath.section)

            let newsItem  = news[indexPath.section]
       
            cell.configure(newsItem: newsItem, cellIndex: indexPath.section)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if let cell = cell as? NewsPhotoTableViewCell  {
            
            guard !(news[indexPath.section].attachments?.isEmpty ?? true) && news[indexPath.section].attachments?[0].photo?.sizes?[0].url != nil else {return}

            cell.photoNewsCollectionView.dataSource = self
            cell.photoNewsCollectionView.delegate = self
            cell.photoNewsCollectionView.tag = indexPath.section
            cell.photoNewsCollectionView.reloadData()

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else if indexPath.row == 2 && !(news[indexPath.section].attachments?.isEmpty ?? true) && news[indexPath.section].attachments?[0].photo != nil {
            return 180
        } else {
            newsTable.estimatedRowHeight = 44.0
            newsTable.rowHeight = UITableView.automaticDimension
            return newsTable.rowHeight
        }
    }

}


extension NewsV2ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsPhotoCollectionViewCell", for: indexPath) as! NewsPhotoCollectionViewCell
        
        guard let url = news[collectionView.tag].attachments?[indexPath.row].photo?.sizes?[0].url else {
            preconditionFailure("Error")
        }

        //кеширование
        let image = photoService?.photo(atIndexpath: indexPath, byUrl: url)
        
        cell.newsPhoto.image = image
        
//        Utilities().UrlToImage(url: url) { res in
//            cell.newsPhoto.image = res
//        }
      
        return cell
    }
    
    
}
