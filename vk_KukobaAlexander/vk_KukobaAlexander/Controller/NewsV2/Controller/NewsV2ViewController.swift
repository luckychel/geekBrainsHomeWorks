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
   
    var profiles: [ProfileItem]!
    var groups: [GroupItem]!
    var news: [NewsItem]!
    
    private var photoService: PhotoService?
    
    private let dateFormatter = DateFormatter()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTable.dataSource = self
        newsTable.delegate = self
        newsTable.delegate = self

        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current

        photoService = PhotoService(container: newsTable)
        
        vkApi.getNews(token: session.token, id: session.userId) { res in
 
            //guard res.profiles?.count ?? 0 > 0  else {return}
            //guard res.groups?.count ?? 0 > 0  else {return}
            guard res.newsfeed?.count ?? 0 > 0  else {return}
            
            self.profiles = res.friends
            self.groups = res.groups
            self.news = res.newsfeed
            
            DispatchQueue.main.async {
                self.newsTable.reloadData()
            }

            
          
        }
    }
    

}

extension NewsV2ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard news.count > 0 else { return 0 }
        guard (!news[section].attachments?.contains(where: { $0.type == .photo})) != nil
                && news[section].text != "" else { return 2 }
        guard (news[section].attachments?.contains(where: { $0.type == .photo})) != nil
                || news[section].text != "" else { return 3 }
        return 4

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
        
//        print("Прорисовка секции новости \(indexPath.section)")
//        print("Прорисовка строки новости \(indexPath.row)")
        
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsAuthor", for: indexPath) as! NewsAuthorDataTableViewCell
//
//            cell.configure(index: indexPath.section)
//
//            var url: String?
//            let index = indexPath.section
//            if ((self.news[index].sourceId ?? 0) > 0) {
//                //profile
//                let source = profiles.filter({ $0.id == (news[index].sourceID)! });
//                cell.author.text = !source.isEmpty ? (source[0].firstName ?? "") + " " + (source[0].lastName ?? "") : ""
//                url = !source.isEmpty ? source[0].photo100 : "https://vk.com/images/camera_100.png"
//            } else {
//                //group
//                let source = groups.filter({ $0.id == (-1) * (news[index].sourceID)!}) ;
//                cell.author.text = !source.isEmpty ? source[0].name: ""
//                url = !source.isEmpty ? source[0].photo100 : "https://vk.com/images/camera_100.png"
//            }
//
//            let timeResult = Double(news[index].date ?? 0)
//            let date = Date(timeIntervalSince1970: timeResult)
//            let localDate = dateFormatter.string(from: date)
//
//            cell.date.text = localDate
//
//            //кеширование
//            let image = photoService?.photo(atIndexpath: indexPath, byUrl: url ?? "")
//
//            cell.avatar.image = image
//
//            return cell
//
//        case 1:
//
//            if news[indexPath.section].text != "" {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextTableViewCell
//                cell.newsText.text = news[indexPath.section].text
//                return cell
//            } else {
//                if news[indexPath.section].attachments != nil
//                    && news[indexPath.section].attachments?.contains(where: { $0.type == .photo}) != nil {
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoTableViewCell", for: indexPath) as! NewsPhotoTableViewCell
//                        return cell
//                } else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikeCommentsCell", for: indexPath) as! NewsLikeCommentsTableViewCell
//
//                    let newsItem  = news[indexPath.section]
//
//                    cell.configure(newsItem: newsItem, cellIndex: indexPath.section)
//
//                    return cell
//                }
//            }
//        case 2:
//            if news[indexPath.section].attachments != nil
//                && news[indexPath.section].attachments?.contains(where: { $0.type == .photo}) != nil {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoTableViewCell", for: indexPath) as! NewsPhotoTableViewCell
//                    return cell
//            } else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikeCommentsCell", for: indexPath) as! NewsLikeCommentsTableViewCell
//
//                let newsItem  = news[indexPath.section]
//
//                cell.configure(newsItem: newsItem, cellIndex: indexPath.section)
//
//                return cell
//            }
//        default:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikeCommentsCell", for: indexPath) as! NewsLikeCommentsTableViewCell
//
//            //print(indexPath.section)
//
//            let newsItem  = news[indexPath.section]
//
//            cell.configure(newsItem: newsItem, cellIndex: indexPath.section)
//
//            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

//        if let cell = cell as? NewsPhotoTableViewCell  {
//
//            guard !(news[indexPath.section].attachments?.isEmpty ?? true) && news[indexPath.section].attachments?[0].photo?.sizes?[0].url != nil else {return}
//
//            cell.photoNewsCollectionView.dataSource = self
//            cell.photoNewsCollectionView.delegate = self
//            cell.photoNewsCollectionView.tag = indexPath.section
//            cell.photoNewsCollectionView.reloadData()
//
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
        
//        if indexPath.row == 0 {
//            let width = view.frame.width
//            return width
//        } else
//        if indexPath.row == 1 {
//            if ((news[indexPath.section].text ?? "").isEmpty) {
//                return 0
//            }
//            return UITableView.automaticDimension
//        } else
//        if indexPath.row == 2 && !(news[indexPath.section].attachments?.isEmpty ?? true) && news[indexPath.section].attachments?[0].photo != nil {
//            let width = view.frame.width
//            return width
//        } else {
//            newsTable.estimatedRowHeight = 44.0
//            newsTable.rowHeight = UITableView.automaticDimension
//            return newsTable.rowHeight
//        }
    }

}


extension NewsV2ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
      
         return NewsPhotoCollectionViewCell()
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsPhotoCollectionViewCell", for: indexPath) as! NewsPhotoCollectionViewCell
//
//        guard let url = news[collectionView.tag].attachments?[indexPath.row].photo?.sizes?.last?.url else {
//            preconditionFailure("Error")
//        }
//
//        //кеширование
//        let image = photoService?.photo(atIndexpath: indexPath, byUrl: url)
//
//        cell.newsPhoto.image = image
//
//        return cell
    }
    
    
}
