//
//  ThreePicsCollectionViewCell.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 29/8/21.
//

import UIKit

class ThreePicsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    static let reuseIdentifier = "ThreePicsCollectionViewCellId"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var settings: PostCellModel? {
        
        didSet {
            dateLabel.text = settings?.post.datePost
            mainImageView.loadImageFrom(url: settings?.post.postImageUrl[0] ?? "")
            leftImageView.loadImageFrom(url: settings?.post.postImageUrl[1] ?? "")
            rightImageView.loadImageFrom(url: settings?.post.postImageUrl[2] ?? "")
        }
    }
}
