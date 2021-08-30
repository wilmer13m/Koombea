//
//  FeedInteractor.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

class FeedInteractor: PrensenterToInteractorFeedProtocol {
      
    weak var presenter: InteractorToPresenterFeedProtocol?
        
    func retrieveFeed() {
        
        FeedService.shared.getPosts { [weak self] (result) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            
            case .success(let response):
                
                self.presenter?.fetchFeedSuccess(feed: response)

            case .failure(let error):
                self.presenter?.fetchFeedFailure(error: error)
            }
        }
    }
}
