//
//  FeedRouter.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import UIKit

class FeedRouter: PresenterToRouterFeedProtocol {
   
    static func createModule() -> UIViewController {
      
        let viewController = FeedViewController()
        
        let presenter: ViewToPresenterFeedProtocol & InteractorToPresenterFeedProtocol = FeedPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = FeedRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = FeedInteractor()
        viewController.presenter?.interactor?.presenter = presenter

        return viewController
    }
    
    // MARK: - Navigation
    func pushToFullScreenPitcure(on view: PresenterToViewFeedProtocol, with image: UIImage) {
                   
        let fullScreenPictureViewController = FullScreenPictureRouter.createModule(with: image)
            
        let viewController = view as! FeedViewController
        viewController.present(fullScreenPictureViewController, animated: false, completion: nil)
    }
}
