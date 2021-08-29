//
//  FeedInteractor.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

class FeedInteractor: PrensenterToInteractorFeedProtocol {
      
    weak var presenter: InteractorToPresenterFeedProtocol?
    
    var feed: Feed? //***
    
    func retrieveFeed() {
        
        FeedService.shared.getPosts { [weak self] (result) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            
            case .success(let response):
                self.feed = response
                self.presenter?.fetchFeedSuccess(feed: self.feed!)

            case .failure(let error):
                self.presenter?.fetchFeedFailure(error: error)
            }
        }
    }
}
