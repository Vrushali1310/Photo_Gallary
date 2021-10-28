//
//  ImageCacheManager.swift
//  Gallery
//
//  Created by Apple on 28/10/21.
//

import Foundation
import UIKit

class ImageCacheManager: NSObject {
    
    private override init() { }
    static let shared = ImageCacheManager()
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    func cacheImage(imageUrl: String, onFetch: @escaping (UIImage?) -> Void) {
        
        if let imageFromCache = imageCache.object(forKey: imageUrl as AnyObject) as? UIImage {
            onFetch(imageFromCache)
        } else {
            fetchImage(from: imageUrl) { [weak self] data in
                if let imageData = data, let image = UIImage(data: imageData) {
                    self?.imageCache.setObject(image, forKey: imageUrl as AnyObject)
                    onFetch(UIImage(data: imageData))
                }
            }
        }
        
    }
    
   private func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        if let url = URL(string: urlString) {
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completionHandler(nil)
                } else {
                    completionHandler(data)
                }
            }
            dataTask.resume()
        }
    }
}
