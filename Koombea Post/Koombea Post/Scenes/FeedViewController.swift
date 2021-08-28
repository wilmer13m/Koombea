//
//  PostFeedViewController.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import UIKit

class FeedViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var postCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Vars
    var presenter: ViewToPresenterFeedProtocol?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK:- ViewController's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
        settingCollectionView()
    }
    
    //MARK:- Settings
    func settingCollectionView() {
        postCollectionView.addSubview(refreshControl)
//        collectionView.collectionViewLayout = HomeViewController.createCompLayout()
//        postCollectionView.backgroundColor = UIColor.blue
        postCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

//        postCollectionView.register(UINib(nibName: "ShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ShowCollectionViewCell.reuseIdentifier)
    }
    
    // MARK: - Actions
     @objc func refresh() {
         presenter?.refresh()
     }
}

//MARK:- Extension

extension FeedViewController: PresenterToViewFeedProtocol {
    
    func onFetchFeedSuccess() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.postCollectionView.reloadData()
        }
    }
    
    func onFecthFeedFailure(with error: ServiceErrors) {
        self.refreshControl.endRefreshing()
    }

    
    func showHUD() {
        activityIndicator.startAnimating()
    }
    
    func hideHUD() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}

extension FeedViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(presenter?.numberOfSection() ?? 0)
        return presenter?.numberOfSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(presenter?.numberOfRows(in: section) ?? 0)
        return presenter?.numberOfRows(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewCell else { fatalError("com.moviex.error.deque.cell")
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
        
        return header
    }
}

extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
