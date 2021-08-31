//
//  MockPresenterToViewFeedProtocol.swift
//  Koombea PostTests
//
//  Created by Wilmer Mendoza on 31/8/21.
//

import Foundation
@testable import Koombea_Post

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

