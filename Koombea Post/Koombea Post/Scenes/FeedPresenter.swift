//
//  FeedPresenter.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import UIKit

class FeedPresenter: ViewToPresenterFeedProtocol {
    
    weak var view: PresenterToViewFeedProtocol?
    
    var interactor: PrensenterToInteractorFeedProtocol?
    var router: PresenterToRouterFeedProtocol?
    
    var posts: [Feed.PostData]?
    
    //Mark:- ViewToPresenterFeedProtocol Funcs
    func viewDidLoad() {
        view?.showHUD()
        interactor?.retrieveFeed()
    }
    
    func numberOfRows(in section: Int) -> Int {
        posts?[section].posts.count ?? 0
    }
    
    func numberOfSection() -> Int {
        posts?.count ?? 0
    }
    
    func refresh() {
        interactor?.retrieveFeed()
    }
    
    func postInfo(for indexPath: IndexPath) -> Feed.PostData? {
        return posts?[indexPath.section]
    }
}

//MARK:- Extension
extension FeedPresenter: InteractorToPresenterFeedProtocol {
    
    func fetchFeedSuccess(feed: Feed) {
        
        view?.hideHUD()
        posts = feed.data
        view?.onFetchFeedSuccess()
    }
    
    func fetchFeedFailure(error: ServiceErrors) {
        
        view?.hideHUD()
        view?.onFecthFeedFailure(with: error)
    }
}
