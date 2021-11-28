//
//  ImageCollectionViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit
import EzImageLoader
import EzHTTP

class ImagesCollectionViewModel {
    
    let numberOfCells: Int

    init(numberOfCells: Int) {
        self.numberOfCells = numberOfCells
    }
    
    func getImageView(completion: @escaping ((UIImageView?)-> Void)) {
        let iv = UIImageView()
        ImageLoader.get("https://picsum.photos/200") {
            iv.image = $0.image
            completion(iv)
        }
        
    }
}
