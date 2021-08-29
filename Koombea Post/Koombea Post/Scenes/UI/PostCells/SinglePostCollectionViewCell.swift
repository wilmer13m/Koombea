//
//  SinglePostCollectionViewCell.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import UIKit

class SinglePostCollectionViewCell: UICollectionViewCell {

    //MARK:- Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    static let reuseIdentifier = "SinglePostCollectionViewCellId"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var settings: PostCellModel? {
        didSet {
            
            dateLabel.text = settings?.post.datePost
            postImageView.loadImageFrom(url: settings?.post.postImageUrl[0] ?? "")
        }
    }
}
