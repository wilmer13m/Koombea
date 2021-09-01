//
//  HeaderPostCollectionReusableView.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 29/8/21.
//

import UIKit
import SkeletonView

class HeaderPostCollectionReusableView: UICollectionReusableView {

    //MARK:- Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    static let reeuseIdentifier = "HeaderPostCollectionReusableViewId"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = 33 / 2
        showSkeleton()
    }
    
    var settings: HeaderPostModel? {
        didSet {
            
            hideSkeleton()

            avatarImageView.loadImageFrom(url: settings?.avatarImageUrl ?? "")
            userNameLabel.text = settings?.userName
            emailLabel.text = settings?.email
            
        }
    }
    
    func showSkeleton() {
        avatarImageView.showGradientSkeleton()
        userNameLabel.showGradientSkeleton()
        emailLabel.showGradientSkeleton()
    }
    
    func hideSkeleton() {
        avatarImageView.hideSkeleton()
        userNameLabel.hideSkeleton()
        emailLabel.hideSkeleton()
    }
}
