//
//  PostService.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import UIKit

class PostService {

    static let shared = PostService()
    private let endPoints = EndPoints()
    
    func getPosts(completed: @escaping (Result<PostResponse, ServiceErrors>) -> Void) {
        
        let urlString = endPoints.getPostURL()
        print(urlString)
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
                deconder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try deconder.decode(PostResponse.self, from: data)
                completed(.success(results))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
