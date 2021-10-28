//
//  PhotoCollectionViewCell.swift
//  Gallery
//
//  Created by Apple on 27/10/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
        
    @IBOutlet weak var photoImageView: UIImageView!
    
    func setCellData(photoModelObject: PhotoModel) {
        if let imageUrlString = photoModelObject.url {
            ImageCacheManager.shared.cacheImage(imageUrl: imageUrlString) { image in
                DispatchQueue.main.async { [weak self] in
                    self?.photoImageView.image = image
                }
            }
        }
    }
    
}
