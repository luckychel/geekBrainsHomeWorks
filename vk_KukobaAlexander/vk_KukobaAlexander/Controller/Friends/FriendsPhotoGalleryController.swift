//
//  FriendsPhotoGalleryController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 14.07.2022.
//

import UIKit

class FriendsPhotoGalleryController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var images = [UIImage]()
    var indexPath: IndexPath!
    
    private let reuseIdentifier = "FriendPhotoCell"
    
    let countCells = 1
    let offset:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
}

extension FriendsPhotoGalleryController:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.photoImage.image = images[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameVC = collectionView.frame
        let widthCell = frameVC.width / CGFloat(countCells)
        let heigthCell = widthCell
        let spacing = CGFloat(countCells + 1) * offset / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heigthCell - spacing)
        
    }

    
    
}
