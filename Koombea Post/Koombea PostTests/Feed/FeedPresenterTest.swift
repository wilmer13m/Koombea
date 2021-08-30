//
//  FeedPresenterTest.swift
//  Koombea PostTests
//
//  Created by Wilmer Mendoza on 30/8/21.
//

import XCTest
@testable import Koombea_Post

class FeedPresenterTest: XCTestCase {

    var sut: FeedPresenter?
    var mockView: MockPresenterToViewFeedProtocol?
    var mockInteractor: MockPrensenterToInteractorProtocol?
    var mockRouter: MockPresenterToRouterFeedProtocol?

    override func setUp() {
        super.setUp()
        
        sut = FeedPresenter()
        mockView = MockPresenterToViewFeedProtocol()
        mockInteractor = MockPrensenterToInteractorProtocol()
        mockRouter = MockPresenterToRouterFeedProtocol()
        mockInteractor?.presenter = sut
        sut?.view = mockView
        sut?.interactor = mockInteractor
        sut?.router = mockRouter
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        
        super.tearDown()
    }
    
    // We can check that the interactor is called when signing in.
    func testInteractorStarToRequestFeed() {
        sut?.viewDidLoad()
        XCTAssertTrue(mockInteractor?.procesing ?? false)
    }
    
    //This test checks if loader appears when viewDidLoad() is called
    func testViewLoadingStateChangesWhenViewIsLoaded() {
      mockInteractor?.noReturn = true
      sut?.viewDidLoad()
      XCTAssertTrue(mockView?.loading ?? false)
    }
    
    // This test checks to make sure that we tell the view to finish loading when a result comes back as successful.
    func testUpdatesViewWhenSuccessIsReturned() {
        
        sut?.viewDidLoad()
        XCTAssertFalse(mockView?.loading ?? true)
    }
    
    // My forcing the interactor mock to fail. We can test that the presenter is still updating the view to finishing loading.
    func testWhenFailureItUpdatesView() {
        mockInteractor?.fail = true
        sut?.viewDidLoad()
        XCTAssertFalse(mockView?.loading ?? true)
    }
    
    // This test checks that tableView is reloaded when fetch feed is success.
    func testTableViewIsReloadedOnView() {
        sut?.viewDidLoad()

        XCTAssertTrue(mockView?.collectionViewIsReloaded ?? false)
    }
    
    // This test checks that refresh control is hidden when fetch feed is fail.
    func testRefresControlIsEnded() {
        sut?.viewDidLoad()
        mockInteractor?.fail = true
        XCTAssertFalse(mockView?.refreshControlEndRefreshing ?? true)
    }
}

class MockPresenterToViewFeedProtocol: PresenterToViewFeedProtocol {
   
    var loading = false
    var collectionViewIsReloaded = false
    var refreshControlEndRefreshing = false
    
    func onFetchFeedSuccess() {
        collectionViewIsReloaded = true
    }
    
    func onFecthFeedFailure(with error: ServiceErrors) {
        refreshControlEndRefreshing = false
    }
    
    func showHUD() {
        loading = true
    }
    
    func hideHUD() {
        loading = false
    }
}

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

struct MockFeed {
    static let feed = Feed(data: [Feed.PostData(uid: "1",
                                                name: "wilmer",
                                                email: "email1@hotmail.com",
                                                profilePic: nil,
                                                posts: [Feed.PostData.Post(id: 1,
                                                                           date: "Tue Oct 12 2021 08:25:06 GMT-050",
                                                                           pics: ["somePics"])]),
                                  Feed.PostData(uid: "1",
                                                name: "Karen",
                                                email: "email2@hotmail.com",
                                                profilePic: nil,
                                                posts: [Feed.PostData.Post(id: 3,
                                                                           date: "Thu Mar 17 2022 08:25:06 GMT-050",
                                                                           pics: [""])])])
}
