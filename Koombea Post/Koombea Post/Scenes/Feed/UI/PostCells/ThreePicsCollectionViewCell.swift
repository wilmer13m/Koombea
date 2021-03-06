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

    weak var delegate: ImageSelectecion?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        settingImageViews()
    }

    var settings: PostCellModel? {
        
        didSet {
            dateLabel.text = settings?.post.datePost
            mainImageView.loadImageFrom(url: settings?.post.postImageUrl[0] ?? "")
            leftImageView.loadImageFrom(url: settings?.post.postImageUrl[1] ?? "")
            rightImageView.loadImageFrom(url: settings?.post.postImageUrl[2] ?? "")
        }
    }
    
    private func settingImageViews() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(fisrtPicImageViewTapped))
        tap.numberOfTapsRequired = 1
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(leftPicImageViewTapped))
        tap2.numberOfTapsRequired = 1
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(rightPicImageViewTapped))
        tap3.numberOfTapsRequired = 1
        
        mainImageView.addGestureRecognizer(tap)
        leftImageView.addGestureRecognizer(tap2)
        rightImageView.addGestureRecognizer(tap3)
    }
    
    @objc func fisrtPicImageViewTapped() {
        delegate?.openImage(image: mainImageView.image)
    }
    
    @objc func leftPicImageViewTapped() {
        delegate?.openImage(image: leftImageView.image)
    }
    
    @objc func rightPicImageViewTapped() {
        delegate?.openImage(image: rightImageView.image)
    }
}
