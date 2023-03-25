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
        
        var cnt: Int = 2
        
        if news[section].text != "" {
            cnt = cnt + 1
        }

        let isPhoto = !news[section].attachments.isEmpty && news[section].attachments.contains(where: {$0.type == "photo"})
        
        if isPhoto {
            cnt = cnt + 1
        }

        return cnt

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //return UITableViewCell()
        
        print("Прорисовка секции новости \(indexPath.section)")
        print("Прорисовка строки новости \(indexPath.row)")
        
        let isPhoto = !news[indexPath.section].attachments.isEmpty && news[indexPath.section].attachments.contains(where: {$0.type == "photo"})
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsAuthor", for: indexPath) as! NewsAuthorDataTableViewCell

            cell.configure(index: indexPath.section)

            let index = indexPath.section
            
            let url: String? = self.news[index].authorImageUrl
            cell.author.text = self.news[index].author
            
            let timeResult = Double(news[index].date)
            let date = Date(timeIntervalSince1970: timeResult)
            let localDate = dateFormatter.string(from: date)

            cell.date.text = localDate

            //кеширование
            let image = photoService?.photo(atIndexpath: indexPath, byUrl: url ?? "")

            DispatchQueue.main.async {
                cell.avatar.image = image
            }
            
            return cell

        case 1:

            if !news[indexPath.section].text.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextTableViewCell
                cell.newsText.text = news[indexPath.section].text
                return cell
            } else {
                if isPhoto {
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
            if isPhoto {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoTableViewCell", for: indexPath) as! NewsPhotoTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikeCommentsCell", for: indexPath) as! NewsLikeCommentsTableViewCell

                let newsItem  = news[indexPath.section]

                cell.configure(newsItem: newsItem, cellIndex: indexPath.section)

                return cell
            }
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikeCommentsCell", for: indexPath) as! NewsLikeCommentsTableViewCell

            let newsItem  = news[indexPath.section]

            cell.configure(newsItem: newsItem, cellIndex: indexPath.section)

            return cell
        default:
            return UITableViewCell()
         
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if let cell = cell as? NewsPhotoTableViewCell  {

            
            guard !news[indexPath.section].attachments.isEmpty && news[indexPath.section].attachments.contains(where: {$0.type == "photo"}) else { return }
            
//            guard !(news[indexPath.section].attachments?.isEmpty ?? true) && news[indexPath.section].attachments?[0].photo?.sizes?[0].url != nil else {return}

            cell.photoNewsCollectionView.dataSource = self
            cell.photoNewsCollectionView.delegate = self
            cell.photoNewsCollectionView.tag = indexPath.section
            cell.photoNewsCollectionView.reloadData()

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        let isPhoto = !news[indexPath.section].attachments.isEmpty && news[indexPath.section].attachments.contains(where: {$0.type == "photo"})
        
        if indexPath.row == 0 {
            //let width = view.frame.width
            return 80
        } else
        if indexPath.row == 1 {
            if !news[indexPath.section].text.isEmpty {
                return UITableView.automaticDimension
            }
            else {
                if isPhoto {
                    return UITableView.automaticDimension
                }
                else {
                    return 35
                }
            }
        } else
        if indexPath.row == 2 && !news[indexPath.section].attachments.isEmpty && news[indexPath.section].attachments.contains(where: {$0.type == "photo"}) {
            let width = view.frame.width
            return width
        } else {
            return 35
        }
    }

}


extension NewsV2ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
      
         //return NewsPhotoCollectionViewCell()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsPhotoCollectionViewCell", for: indexPath) as! NewsPhotoCollectionViewCell

        guard let url = news[collectionView.tag].attachments[indexPath.row].url else {
            preconditionFailure("Error")
        }

        //кеширование
        let image = photoService?.photo(atIndexpath: indexPath, byUrl: url)

        
        DispatchQueue.main.async {
            cell.newsPhoto.image = image
        }
       

        return cell
    }
    
    
}
