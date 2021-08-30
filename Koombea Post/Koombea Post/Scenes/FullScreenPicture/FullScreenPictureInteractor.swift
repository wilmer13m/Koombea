//
//  FullScreenPictureInteractor.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 29/8/21.
//

import UIKit

class FullScreenPictureInteractor: PrensenterToInteractorPictureProtocol {
    
    weak var presenter: InteractorToPresenterPictureProtocol?
    var image: UIImage?

    func retrievePicture() {
        
        guard let image = image else {return}
        presenter?.fetchPictureSuccess(picture: image)
    }
}
