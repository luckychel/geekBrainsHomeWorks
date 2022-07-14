//
//  PhotoCollectionViewCell.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 14.07.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var photoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        photoImage.translatesAutoresizingMaskIntoConstraints = false
//        photoImage.clipsToBounds = true
//        photoImage.contentMode = .scaleAspectFit
//        photoImage.isUserInteractionEnabled = true
    }

}
