//
//  FriendsCollectionViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 28.06.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendsCollectionViewController: UICollectionViewController {

    var arrayFriends : [Friend]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayFriends?.count ?? 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //guard arrayFriends?.count ?? 0 > 0 else { preconditionFailure("Error casting FriendCollectionViewCell") }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionFriends", for: indexPath) as? FriendCollectionViewCell
        else {
            preconditionFailure("Error casting FriendCollectionViewCell")
        }
        
        if arrayFriends?.count ?? 0 > 0 {
            cell.nameFriend.text = arrayFriends?[indexPath.row].name
            cell.imageFriend.image = arrayFriends?[indexPath.row].avatar
        }
        else
        {
            cell.nameFriend.text = arrayFriends?[indexPath.row].name
            cell.nameFriend.text = "No friends"
        }
        
        return cell
    
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard arrayFriends != nil else {
            return
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FriendsPhotoGalleryController") as! FriendsPhotoGalleryController

        var images = [UIImage]()
        for fr in arrayFriends! {
            if fr.avatar != nil {
                images.append(fr.avatar!)
            }
        }
    
        //vc.modalPresentationStyle = .currentContext
        vc.images = images
        vc.myIndexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
