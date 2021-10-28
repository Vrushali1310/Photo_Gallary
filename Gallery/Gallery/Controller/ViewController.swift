//
//  ViewController.swift
//  Gallery
//
//  Created by Apple on 27/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    var imageArray: [PhotoModel] = []
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet var popUpView: PopUpView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImagesFromServer()
        customizePopUpView()
    }
    
    func fetchImagesFromServer() {
        ServerManager.shared.getImages { [weak self] photoModelArray in
            self?.imageArray = photoModelArray
            self?.popUpView.imageArray = photoModelArray
            DispatchQueue.main.async {
                self?.imageCollectionView.reloadData()
            }
        } onFailure: {
            print("Something went wrong")
        }
    }
    
    func customizePopUpView() {
        popUpView.frame = view.frame
        view.addSubview(popUpView)
        popUpView.bringSubviewToFront(view)
        popUpView.isHidden = true
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath as IndexPath) as? PhotoCollectionViewCell {
            let image = imageArray[indexPath.row]
            cell.setCellData(photoModelObject: image)
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalHeight: CGFloat = (self.view.bounds.width / 3) - 2
        return CGSize(width: totalHeight, height: totalHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        popUpView.isHidden = false
        popUpView.setImageToIndex(index: indexPath.row)
        
    }
}




