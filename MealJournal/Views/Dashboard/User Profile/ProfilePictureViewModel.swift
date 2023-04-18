//
//  ProfilePictureViewModel.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/5/23.
//

import Foundation
import SwiftUI

//load URL image
class UrlImageModel: ObservableObject {
    @Published var image: UIImage?
    @Published var urlString: String?
    var imageCache = CacheImageManager.getImageCache()
     @Published var newImageAdded = false
     @Published var pulledCacheImage: UIImage?
     init (urlString: String?) {
         self.urlString = urlString
         loadImage()
    
     }
  
    func loadImage() {
        guard let urlString = urlString else {
            return
        }
        if newImageAdded {
            print("new Image Added")
            loadImageFromURL()
        }
       else if loadImageFromCache() && newImageAdded {
            print("cache located") // AFTER INPUT LOADING, NO NEW IMAGE
            return
        }
        else{
            print("loading from URL") // << 6th
            loadImageFromURL()
        }
        
    }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            print("urlString is nil")
            return false
        }
        
       // print("cache LOADING: \(imageCache)") // << after input input second outcome printed // 4th after refreshing NO NEW IMAGE
        
        guard let cacheImage = imageCache.getCache(forKey: urlString) else {
            print("cache not found for key: \(urlString)") // << 5th SHOWS NEW IMAGE!! OR INIATIES IT
            return false
        }
        
        image = cacheImage
        return true
    }

    func loadImageFromURL (){
      
        guard let urlString = urlString else {
                 return
             }
        let url = URL(string: urlString)!
           let task = URLSession.shared.dataTask(with:url, completionHandler:
                                                   getImageFromResponse(data: response: error: ))
           task.resume()
    }
    
    func getImageFromResponse (data: Data?, response: URLResponse?, error: Error?){
        DispatchQueue.main.async {
         
            guard error == nil else {
                print("error: \(error!)")
                return
            }
        }
        
        guard let data = data else {
            print("no data for image found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.imageCache.setCache(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
        }
    }
}

class CacheImageManager {
    static let shared = CacheImageManager()
    private lazy var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func getCache(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }
    
    func setCache(forKey key: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: key))
    }
    
    func removeCache(forKey key: String) {
        cache.removeObject(forKey: NSString(string: key))
    }
}
extension CacheImageManager{
    private static var imageCache = CacheImageManager()
    static func getImageCache() -> CacheImageManager {
        imageCache
    }
}
