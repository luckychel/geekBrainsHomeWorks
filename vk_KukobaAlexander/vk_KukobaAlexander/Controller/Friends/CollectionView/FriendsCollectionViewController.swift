//
//  FriendsCollectionViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 28.06.2022.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class FriendsCollectionViewController: BaseUICollectionViewController {

    let session = Session.shared
    let vkApi = VKApi.shared

    var realm: Realm?
    
    var token: NotificationToken?
    
    var arrayFriends : [Friend]? = []
    
    var userId : Int = 0
    
    var photos = [VkPhoto]()
    
    let refresh = UIRefreshControl()
    
    private var photoService: PhotoService?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        photoService = PhotoService(container: collectionView)
        
        // Включает вертикальный скрол приндутельно для появления обновления свайпом сверху вниз
        self.collectionView.alwaysBounceVertical = true
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        refresh.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        collectionView.addSubview(refresh)
        
        guard let realm = RealmHelper.getRealm() else { return }
        self.realm = realm
        //print(realm.configuration.fileURL)

        //MARK: Проверка на существование объекта Photos в Realm
        let photos = realm.objects(VkPhoto.self).where {
            ($0.owner_id == self.userId)
        }
        
        if photos.isEmpty {
            self.refreshData(self)
        }
        else {
            self.setPhotos(Array(photos))
        }
        
        token = photos.observe{( changes: RealmCollectionChange) in
            guard let collectionView = self.collectionView else { return }

            switch changes {
                case .initial(_):
                    print("initial")
                    self.reloadData()
                case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                    collectionView.performBatchUpdates({
                        collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                        collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                        collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                    }, completion: nil)

                case .error(let err):
                    print(err)
            }
        }
        
//        self.collectionView?.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if let observedObject = object as? UICollectionView, observedObject == self.collectionView {
//            print("collectionViewDidLoad")
//            self.collectionView?.removeObserver(self, forKeyPath: "contentSize")
//        }
//    }
    
    private func setPhotos(_ photos: [VkPhoto]) {
        print("set data")
        self.photos = photos
        self.reloadData()
    }
    
    private func reloadData() {
        print("reload data")
        self.collectionView.reloadData()
    }
    
    @objc private func refreshData(_ sender: AnyObject)  {
        
        print("=====START LOADING=====")
        self.startLoading()
        
        vkApi.getUserPhotos(token: session.token, id: self.userId, completion: { [weak self] in
            
            guard let self = self else { return }
            
            guard let realm = RealmHelper.getRealm() else { return }
            
            let photos = realm.objects(VkPhoto.self).where {
                ($0.owner_id == self.userId)
            }

            for fr in photos {
                
                Utilities().UrlToData(url: fr.url) { res in
                    try! self.realm!.write {
                        fr.savedImage = res
                    }
                }
                
//                let url = URL(string: fr.url)
//                if let data = try? Data(contentsOf: url!) {
//                    try! self.realm!.write {
//                        fr.savedImage = data
//                    }
//                }
            }
            
            self.setPhotos(Array(photos))
            
            print("=====END LOADING======")
            self.endLoading()
            
            if self.refresh.isRefreshing {
                self.refresh.endRefreshing()
            }

        })
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //guard arrayFriends?.count ?? 0 > 0 else { preconditionFailure("Error casting FriendCollectionViewCell") }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionFriends", for: indexPath) as? FriendCollectionViewCell
        else {
            preconditionFailure("Error casting FriendCollectionViewCell")
        }
        
        cell.nameFriend.text = ""
        
        //кеширование
        let image = photoService?.photo(atIndexpath: indexPath, byUrl: photos[indexPath.row].url)
        
        cell.imageFriend.image = image
        
//        if let savedImage = photos[indexPath.row].savedImage {
//            cell.imageFriend.image = UIImage(data: savedImage)
//        }
//        else
//        {
//            Utilities().UrlToData(url: photos[indexPath.row].url) { res in
//                cell.imageFriend.image = UIImage(data: res)
//                try! self.realm!.write {
//                    self.photos[indexPath.row].savedImage = res
//                }
//            }
//        }
        
        return cell
    
    }
    


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard arrayFriends != nil else {
            return
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FriendsPhotoGalleryController") as! FriendsPhotoGalleryController

        var images = [UIImage]()
        for fr in photos {
            if let savedImage = fr.savedImage {
                images.append(UIImage(data: savedImage)!)
            }
        }
    
        //vc.modalPresentationStyle = .currentContext
        vc.images = images
        vc.myIndexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
