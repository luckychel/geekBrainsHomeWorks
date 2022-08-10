//
//  FriendsCollectionViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 28.06.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendsCollectionViewController: UICollectionViewController {

    let session = Session.shared
    let vkApi = VKApi.shared
    
    var arrayFriends : [Friend]? = []
    
    var userId : Int = 0
    
    var photos = [VkPhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        vkApi.getUserPhotos(token: session.token, id: self.userId, completion: { [weak self] items in
            
            guard let self = self else { return }
            
            self.photos = items
            
            self.collectionView.reloadData()
        })
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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
        
        let url = URL(string: photos[indexPath.row].url)
        if let data = try? Data(contentsOf: url!) {
            cell.imageFriend.image = UIImage(data: data)
        }
        cell.nameFriend.text = ""

        
        return cell
    
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard arrayFriends != nil else {
            return
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FriendsPhotoGalleryController") as! FriendsPhotoGalleryController

        var images = [UIImage]()
        for fr in photos {
            let url = URL(string: fr.url)
            if let data = try? Data(contentsOf: url!) {
                images.append(UIImage(data: data)!)
            }
        }
    
        //vc.modalPresentationStyle = .currentContext
        vc.images = images
        vc.myIndexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
