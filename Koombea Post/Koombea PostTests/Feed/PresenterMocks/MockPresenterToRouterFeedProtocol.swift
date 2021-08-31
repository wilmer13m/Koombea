//
//  MockPresenterToRouterFeedProtocol.swift
//  Koombea PostTests
//
//  Created by Wilmer Mendoza on 31/8/21.
//

import UIKit

@testable import Koombea_Post

class MockPresenterToRouterFeedProtocol: PresenterToRouterFeedProtocol {
    
    var image: UIImage? ///888
    static func createModule() -> UIViewController {
        UIViewController()
    }
    
    func presentFullScreenPitcure(on view: PresenterToViewFeedProtocol, with image: UIImage) {
        self.image = image
    }
    
    func presentAlertError(on view: PresenterToViewFeedProtocol, title: String, message: String, completionBlock: @escaping () -> ()) { }
}

