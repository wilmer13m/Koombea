//
//  SinglePostCollectionViewCell.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import UIKit

protocol ImageSelectecion: class {
    func openImage(image: UIImage?)
}
class SinglePostCollectionViewCell: UICollectionViewCell {

    //MARK:- Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    weak var delegate: ImageSelectecion?
    
    static let reuseIdentifier = "SinglePostCollectionViewCellId"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        settingImageViews()
        dateLabel.showGradientSkeleton()
        postImageView.showSkeleton()
    }

    var settings: PostCellModel? {
        didSet {
            
            dateLabel.hideSkeleton()
            postImageView.hideSkeleton()
            dateLabel.text = settings?.post.datePost
            postImageView.loadImageFrom(url: settings?.post.postImageUrl[0] ?? "")
            
        }
    }
    
    private func settingImageViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tap.numberOfTapsRequired = 1
        postImageView.addGestureRecognizer(tap)
    }
    
    @objc func imageTapped() {
        delegate?.openImage(image: postImageView.image)
    }
}
