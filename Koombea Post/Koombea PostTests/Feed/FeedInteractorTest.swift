//
//  FeedInteractorTest.swift
//  Koombea PostTests
//
//  Created by Wilmer Mendoza on 30/8/21.
//

import XCTest
@testable import Koombea_Post

class FeedInteractorTest: XCTestCase {

    var sut: FeedInteractor?
    var mockOutPut: MockInteractorToPresenterFeedProtocol?
    var fakeFeedService: FakeFeedService? = FakeFeedService()
    
    override func setUp() {
        super.setUp()
        
        sut = FeedInteractor(service: fakeFeedService!)
        mockOutPut = MockInteractorToPresenterFeedProtocol()
        sut?.presenter = mockOutPut
    }
    
    override func tearDown() {
        sut = nil
        mockOutPut = nil
        fakeFeedService = nil
        
        super.tearDown()
    }
    
    func testSuccessFeedFetchReturnsFeedInSubject() {
        
        loadFeedInSubjectWithSuccess()
        // Returned feeds are caught correctly in the subject under test
        guard let feed = sut?.feed else {
            XCTFail("Nil Feed Returned")
            return
        }
        XCTAssertEqual(feed, StubFeedResult.feed)
    }
    
    func testFeedWithSuccessAreCaughtInSubjectOutputProtocol() {
          
        loadFeedInSubjectWithSuccess()
        
        // Catch Feed in Output Protocol
        guard let feedCaughtInInteractionOutputProtocol = mockOutPut?.feed else {
            XCTFail("Output has caught no Feeds")
            return
        }
        switch StubFeedResult.successfulResult {
        case .success(let feed):
            XCTAssertEqual(feed, feedCaughtInInteractionOutputProtocol)
        default:
            XCTFail("should be case success instead failure")
        }
    }

    func testErrorFeedFetch() {
        
        loadFeedInSubjectWithError()
        
        guard let _ = sut else {
            XCTFail("sut does not be nil here...")
            return
        }
        XCTAssertNil(sut?.feed)
    }
    
    func testFeedFailureErrorCaughtInOutput() {
        
        loadFeedInSubjectWithError()
        // Catch Error in Output Protocol
        switch StubFeedResult.errorResult {
        case .failure(_):
            XCTAssertNotNil(mockOutPut?.error)
            XCTAssertEqual(mockOutPut?.error, .invalidResponse)

        default:
            XCTFail("should be case failure instead success")
        }
    }
    
    private func loadFeedInSubjectWithSuccess() {
        
        fakeFeedService?.result = StubFeedResult.successfulResult
        sut?.retrieveFeed()
    }
    
    private func loadFeedInSubjectWithError() {
        
        fakeFeedService?.result = StubFeedResult.errorResult
        sut?.retrieveFeed()
    }
}

//Helpers - Mockers
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


struct StubFeedResult {
    
    static let errorResult: Result<Feed, ServiceErrors> = Result.failure(ServiceErrors.invalidResponse)
    static let successfulResult: Result<Feed, ServiceErrors> = Result.success(StubFeedResult.feed)
    static let feed = MockFeed.feed
}

class FakeFeedService: FeedServiceProtocol {
    
    var result: Result<Feed, ServiceErrors>?

    func getPosts(completed: @escaping (Result<Feed, ServiceErrors>) -> Void) {
        guard let result = result else {
            XCTFail("Did not supply fake result in Fake Quote Service")
            return
        }
           completed(result)
    }
}
