//
//  PostService.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import UIKit

protocol FeedServiceProtocol: class {
    func getPosts(completed: @escaping (Result<Feed, ServiceErrors>) -> Void)
}

class FeedService: FeedServiceProtocol {

    static let shared = FeedService()
    private let endPoints = EndPoints()
    
    func getPosts(completed: @escaping (Result<Feed, ServiceErrors>) -> Void) {
        
        let urlString = endPoints.getPostURL()

        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let deconder = JSONDecoder()
                let results = try deconder.decode(Feed.self, from: data)
                completed(.success(results))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
