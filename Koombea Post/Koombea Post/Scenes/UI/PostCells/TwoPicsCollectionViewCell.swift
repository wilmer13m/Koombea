//
//  TwoPicsCollectionViewCell.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 29/8/21.
//

import UIKit

class TwoPicsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var datePostLabel: UILabel!
    @IBOutlet weak var fisrtPicImageView: UIImageView!
    @IBOutlet weak var secondPicImageView: UIImageView!
    
    static let reuseIdentifier = "TwoPicsCollectionViewCellId"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var settings: PostCellModel? {
        didSet {
            
            datePostLabel.text = settings?.post.datePost
            fisrtPicImageView.loadImageFrom(url: settings?.post.postImageUrl[0] ?? "")
            secondPicImageView.loadImageFrom(url: settings?.post.postImageUrl[1] ?? "")
        }
    }
}
