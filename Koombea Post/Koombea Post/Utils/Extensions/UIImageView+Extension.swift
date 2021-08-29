//
//  UIImageView+Extension.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImageFrom(url: String) {
        let url = URL(string: url)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: UIImage(systemName: "photo.fill"))
    }
}

