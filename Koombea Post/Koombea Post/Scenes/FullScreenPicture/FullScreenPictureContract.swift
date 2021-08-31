//
//  FullScreenPictureContract.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 29/8/21.
//

import UIKit

//MARK: View Input (View - Presenter)
protocol ViewToPresenterPictureProtocol: class {
    
    var view: PresenterToViewPictureProtocol? { get set }
    var interactor: PrensenterToInteractorPictureProtocol? { get set }
    var router: PresenterToRouterPictureProtocol? { get set }
    var image: UIImage? { get set }
    
    func viewDidLoad()
}

//MARK: View Output (Presenter - View)
protocol PresenterToViewPictureProtocol: class {
    func onFetchPictureSuccess(image: UIImage)
}

//MARK: Interactor Input (Presenter - Interactor)
protocol PrensenterToInteractorPictureProtocol: class {
    var presenter: InteractorToPresenterPictureProtocol? {get set}
    func retrievePicture()
    var image: UIImage? { get set }
}

//MARK: Interactor Output (Interactor - Presenter)
protocol InteractorToPresenterPictureProtocol: class {
    func fetchPictureSuccess(picture: UIImage)
}

//MARK: Router Input (Presenter - Router)
protocol PresenterToRouterPictureProtocol {
    static func createModule(with image: UIImage) -> UIViewController
}
