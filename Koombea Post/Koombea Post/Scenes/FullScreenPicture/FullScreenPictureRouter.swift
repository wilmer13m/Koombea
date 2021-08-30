//
//  FullScreenPictureRouter.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 29/8/21.
//

import UIKit

class FullScreenPictureRouter: PresenterToRouterPictureProtocol {
    
    static func createModule(with image: UIImage) -> UIViewController {
        
        let fullScreenPictureViewController = FullScreenPictureViewController()
                
        let presenter: ViewToPresenterPictureProtocol & InteractorToPresenterPictureProtocol = FullScreenPicturePresenter()
        presenter.view = fullScreenPictureViewController
        presenter.router = FullScreenPictureRouter()
        presenter.interactor = FullScreenPictureInteractor()
        presenter.interactor?.presenter = presenter
        presenter.interactor?.image = image
        
        fullScreenPictureViewController.presenter = presenter
        fullScreenPictureViewController.modalPresentationStyle = .overCurrentContext
        fullScreenPictureViewController.modalTransitionStyle = .crossDissolve
        
        return fullScreenPictureViewController
    }
}
