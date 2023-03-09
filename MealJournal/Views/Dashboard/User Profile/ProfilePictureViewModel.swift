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
    var urlString: String?
    var imageCache = CacheImageManager.getImageCache()
    @Published var isLoading = false
    init (urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage(){
        if loadImageFromCache(){
            print("cache located")
            return
        }
        print("cache not detected ")
         loadImageFromURL()
    }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }
        
        guard let cacheImage = imageCache.getCache(forKey: urlString) else {
            return false
        }
        image = cacheImage
        return true
    }
    
    func loadImageFromURL (){
        isLoading = true // show loading indicator
        guard let urlString = urlString else {
                 return
             }
        let url = URL(string: urlString)!
           let task = URLSession.shared.dataTask(with:url, completionHandler:
                                                   getImageFromResponse(data: response: error: ))
           task.resume()
    }
    
    func getImageFromResponse (data: Data?, response: URLResponse?, error: Error?){
        DispatchQueue.main.async { // switch to the main thread
            self.isLoading = false // hide loading indicator
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
  var cache = NSCache<NSString, UIImage>()
    init(){
        cache.countLimit = 100
       cache.totalCostLimit = 1024 * 1024 * 100
    }
    func getCache (forKey: String) -> UIImage? {
      //  print("grabbing from cache")
        return cache.object(forKey: NSString(string: forKey ))
    }
    func setCache(forKey: String, image: UIImage) {
        print("saving to cache")
        print(forKey)
        return cache.setObject(image, forKey: NSString(string : forKey ))
    }
}
extension CacheImageManager{
    private static var imageCache = CacheImageManager()
    static func getImageCache() -> CacheImageManager {
        imageCache
    }
}
