//
//  PostContract.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import UIKit

//MARK: View Input (View - Presenter)
protocol ViewToPresenterFeedProtocol: class {
    
    var view: PresenterToViewFeedProtocol? { get set }
    var interactor: PrensenterToInteractorFeedProtocol? { get set }
    var router: PresenterToRouterFeedProtocol? { get set }

    func viewDidLoad()
    func numberOfRows(in section: Int) -> Int
    func numberOfSection() -> Int
    func refresh()
//    func tvShow(for indexpath: IndexPath) -> TvShowCellModel?
//    func didSelectRowAt(index: Int)
//    func buttonTvShowTapped(of type: TvShowType)
//    func logOut()
//    func goToLogin()
//    func goToProfile()
}

//MARK: View Output (Presenter - View)
protocol PresenterToViewFeedProtocol: class {
    
    func onFetchFeedSuccess()
    func onFecthFeedFailure(with error: ServiceErrors)
    func showHUD()
    func hideHUD()
}

//MARK: Interactor Input (Presenter - Interactor)
protocol PrensenterToInteractorFeedProtocol: class {
    var presenter: InteractorToPresenterFeedProtocol? {get set}
    func retrieveFeed()
}

//MARK: Interactor Output (Interactor - Presenter)
protocol InteractorToPresenterFeedProtocol: class {
    func fetchFeedSuccess(feed: Feed)
    func fetchFeedFailure(error: ServiceErrors)

//    func fetchTvShowsSuccess(tvShows: TvShowResponse)
//    func fetchTvShowsFailure(error: ApiError)
//    func fetchTvShowsFailureNoConnection()
//    func getTvShowSuccess(_ tvShow: TvShowResponse.Result)
//    func getTvShowFailure()
//    func logOutSuccess()
//    func logOutFail()
}

//MARK: Router Input (Presenter - Router)
protocol PresenterToRouterFeedProtocol {
    static func createModule() -> UIViewController
}
