//
//  PopUpView.swift
//  Gallery
//
//  Created by Apple on 28/10/21.
//

import Foundation
import UIKit


class PopUpView: UIView {
    
    @IBOutlet weak var popUpImageView: UIImageView!
    @IBOutlet weak var backwardArrowButton: UIButton!
    @IBOutlet weak var forwardArrowButton: UIButton!

    var imageArray: [PhotoModel] = []
    var selectedImageIndex: Int = 0
    
    @IBAction func BackButtonAction(_ sender: Any) {
        setImageToIndex(index: selectedImageIndex - 1)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        setImageToIndex(index: selectedImageIndex + 1)
    }
    
    func setImageToIndex(index: Int) {
        selectedImageIndex = index
        handleButtonsDisplay()
        
        if let imageUrlString = imageArray[selectedImageIndex].url {
            
            ImageCacheManager.shared.cacheImage(imageUrl: imageUrlString) { image in
                DispatchQueue.main.async { [weak self] in
                    self?.popUpImageView.image = image
                }
            }
        }
    }
    
    func handleButtonsDisplay() {
        if selectedImageIndex == 0 {
            backwardArrowButton.isHidden = true
        } else {
            backwardArrowButton.isHidden = false
        }
        
        if selectedImageIndex == imageArray.count - 1 {
            forwardArrowButton.isHidden = true
        } else {
            forwardArrowButton.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first
        guard let location = touch?.location(in: self) else { return }
        if !popUpImageView.frame.contains(location) {
            isHidden = true
        }
    }
    
}
