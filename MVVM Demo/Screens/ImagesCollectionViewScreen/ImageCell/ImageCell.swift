//
//  ImageCell.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    func requestImage() {
//        cellImageView = UIImageView(frame: view.bounds)
//        ImageLoader.get("https://picsum.photos/200") {
//            self.cellImageView.image = $0.image
//        }
//    }
    

}
