//
//  ViewController.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostService.shared.getPosts { (result) in
            print(result)
        }
    }
}

