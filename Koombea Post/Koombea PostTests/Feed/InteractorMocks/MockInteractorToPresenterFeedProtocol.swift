//
//  MockInteractorToPresenterFeedProtocol.swift
//  Koombea PostTests
//
//  Created by Wilmer Mendoza on 31/8/21.
//

import Foundation
@testable import Koombea_Post

class MockInteractorToPresenterFeedProtocol: InteractorToPresenterFeedProtocol {
  
    var feed: Feed?
    var error: ServiceErrors?
    
    func fetchFeedSuccess(feed: Feed) {
        self.feed = feed
    }
    
    func fetchFeedFailure(error: ServiceErrors) {
        self.error = error
    }
}
