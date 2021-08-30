//
//  FullScreenPicturePresenter.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 29/8/21.
//

import UIKit

class FullScreenPicturePresenter: ViewToPresenterPictureProtocol {
        
    weak var view: PresenterToViewPictureProtocol?
    
    var interactor: PrensenterToInteractorPictureProtocol?
    var router: PresenterToRouterPictureProtocol?
    var image: UIImage?

    func viewDidLoad() {
        interactor?.retrievePicture()
    }
}

extension FullScreenPicturePresenter: InteractorToPresenterPictureProtocol {
    
    func fetchPictureSuccess(picture: UIImage) {
        view?.onFetchPictureSuccess(image: picture)
    }
}
