//
//  FeedInteractor.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

class FeedInteractor: PrensenterToInteractorFeedProtocol {
      
    weak var presenter: InteractorToPresenterFeedProtocol?
        
    let service: FeedServiceProtocol
    
    var feed: Feed?
    
    init(service: FeedServiceProtocol = FeedService.shared) {
        self.service = service
    }
    func retrieveFeed() {
        
        service.getPosts { [weak self] (result) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            
            case .success(let response):
                self.feed = response
                self.presenter?.fetchFeedSuccess(feed: response)

            case .failure(let error):
                self.presenter?.fetchFeedFailure(error: error)
            }
        }
    }
}
