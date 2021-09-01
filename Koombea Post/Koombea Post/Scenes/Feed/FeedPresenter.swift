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
    
    var postsData: [Feed.PostData]?
    
    //Mark:- ViewToPresenterFeedProtocol Funcs
    func viewDidLoad() {
        view?.showHUD()
        interactor?.retrieveFeed()
    }
    
    func numberOfRows(in section: Int) -> Int {
        postsData?[section].posts.count ?? 0
    }
    
    func numberOfSection() -> Int {
        postsData?.count ?? 0
    }
    
    func refresh() {
        interactor?.retrieveFeed()
    }
    
    func postInfo(for indexPath: IndexPath) -> Feed.PostData? {
        return postsData?[indexPath.section] //data para la seccion 
    }
    
    func getPostForRow(for indexPath: IndexPath) -> Feed.PostData.Post? {
        return postsData?[indexPath.section].posts[indexPath.row]
    }
    
    func getTypeCell(for indexPath: IndexPath) -> CellType {
        
        let numberOfPics = postsData?[indexPath.section].posts[indexPath.row].pics?.count ?? 0
        let typeCell = CellType(rawValue: numberOfPics > 3 ? 4 : numberOfPics)
        
        return typeCell ?? .singlePic
    }
    
    func presentInFullScreen(image: UIImage) {
        
        guard let _ = view else {return}
        router?.presentFullScreenPitcure(on: view!, with: image)
    }
    
    func showAlertError(title: String, message: String) {
        
        guard let _ = view else {return}
        router?.presentAlertError(on: view!, title: title, message: message, completionBlock: {
            self.viewDidLoad()
        })
    }
}

//MARK:- Extension
extension FeedPresenter: InteractorToPresenterFeedProtocol {
    
    func fetchFeedSuccess(feed: Feed) {
        
        view?.hideHUD()
        postsData = feed.data
        view?.onFetchFeedSuccess()
    }
    
    func fetchFeedFailure(error: ServiceErrors) {
        
        view?.hideHUD()
        view?.onFecthFeedFailure(with: error)
    }
}
