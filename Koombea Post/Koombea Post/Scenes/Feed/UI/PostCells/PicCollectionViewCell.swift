//
//  PicCollectionViewCell.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 29/8/21.
//

import UIKit


class PicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
        
    static let reuseIdentifier = "PicCollectionViewCellId"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var imageUrl: String? {
        didSet {
            imageView.loadImageFrom(url: imageUrl ?? "")
        }
    }
}
