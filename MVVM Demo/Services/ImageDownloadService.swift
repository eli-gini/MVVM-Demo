//
//  ImageLoaderWrapper.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 02/12/2021.
//

import Foundation
import EzImageLoader
import EzHTTP

class ImageDownloadService {
    
    func fetchImage(completion: @escaping ((UIImage?)-> Void)) {
        ImageLoader.get("https://picsum.photos/200", nocache: true) {
            completion($0.image)
        }
    }
}
