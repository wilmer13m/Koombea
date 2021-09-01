//
//  FeedInteractor.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import Foundation

class FeedInteractor: PrensenterToInteractorFeedProtocol {
      
    weak var presenter: InteractorToPresenterFeedProtocol?

    var feed: Feed?

    let service: FeedServiceProtocol
    
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
                self.savePostsInDatabase(response: response)
                
                //MARK:- Uncomment the lines below to see the posts stores it in core Data
//                DispatchQueue.main.async {
//                    let x = DatabaseHandler.shared.fetch(type: PostInfoEntity.self)
                    
//                    x.forEach { (item) in
//                        print(item)
//                    }
//                }

            case .failure(let error):
                self.presenter?.fetchFeedFailure(error: error)
            }
        }
    }
    
    func savePostsInDatabase(response: Feed) {
        DispatchQueue.main.async {
            response.data?.forEach({ (post) in
                post.storeInDatabase()
            })
        }
    }
}
