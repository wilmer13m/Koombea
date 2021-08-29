//
//  SinglePostCollectionViewCell.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import UIKit

class SinglePostCollectionViewCell: UICollectionViewCell {

    //MARK:- Outlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    static let reuseIdentifier = "SinglePostCollectionViewCellId"

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    var settings: PostCellModel? {
        didSet {
            
            if !(settings?.posts.isEmpty ?? true)  {
                dateLabel.text = settings?.posts[0].datePost
                postImageView.loadImageFrom(url: settings?.posts[0].postImageUrl[0] ?? "")
            }
        }
    }
}
