//
//  MockPrensenterToInteractorProtocol.swift
//  Koombea PostTests
//
//  Created by Wilmer Mendoza on 31/8/21.
//

import Foundation
@testable import Koombea_Post

class MockPrensenterToInteractorProtocol: PrensenterToInteractorFeedProtocol {

    var presenter: InteractorToPresenterFeedProtocol?
    var noReturn = false
    var procesing: Bool = false
    var fail: Bool = false
    var feed: Feed?
    
    func retrieveFeed() {
        procesing = true
        
        guard !noReturn else { return }

        if fail {
            presenter?.fetchFeedFailure(error: .invalidData)
        
        } else {
            //Mocking feed
            feed = MockFeed.feed
            presenter?.fetchFeedSuccess(feed: feed!)
        }
    }
}
