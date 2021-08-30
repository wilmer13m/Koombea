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

    weak var delegate: ImageSelectecion?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        settingImageViews()
    }

    var settings: PostCellModel? {
        didSet {
            
            datePostLabel.text = settings?.post.datePost
            fisrtPicImageView.loadImageFrom(url: settings?.post.postImageUrl[0] ?? "")
            secondPicImageView.loadImageFrom(url: settings?.post.postImageUrl[1] ?? "")
        }
    }
    
    private func settingImageViews() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(fisrtPicImageViewTapped))
        tap.numberOfTapsRequired = 1
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(secondPicImageViewTapped))
        tap2.numberOfTapsRequired = 1
        
        fisrtPicImageView.addGestureRecognizer(tap)
        secondPicImageView.addGestureRecognizer(tap2)
    }
    
    @objc func fisrtPicImageViewTapped() {
        delegate?.openImage(image: fisrtPicImageView.image)
    }
    
    @objc func secondPicImageViewTapped() {
        delegate?.openImage(image: secondPicImageView.image)
    }
}
