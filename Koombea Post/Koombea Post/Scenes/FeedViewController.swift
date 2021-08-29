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
        refreshControl.attributedTitle = NSAttributedString(string: "com_koobea_post_refreshing".localized())
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    private struct Constants {
        static let nibCarouselCell = "SinglePostCollectionViewCell"
        static let headerCollectionView = "HeaderPostCollectionReusableView"
    }
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
        postCollectionView.register(UINib.init(nibName: Constants.headerCollectionView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPostCollectionReusableView.reeuseIdentifier)

        postCollectionView.register(UINib(nibName: Constants.nibCarouselCell, bundle: nil),
                                    forCellWithReuseIdentifier: SinglePostCollectionViewCell.reuseIdentifier)
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
        return presenter?.numberOfSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRows(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SinglePostCollectionViewCell.reuseIdentifier, for: indexPath) as? SinglePostCollectionViewCell else { fatalError("com_koobea_post_error_deque_cell".localized())
        }
    
        if let postData = presenter?.postInfo(for: indexPath) {
            cell.settings = PostCellModel(postData: postData)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            guard let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPostCollectionReusableView.reeuseIdentifier, for: indexPath) as? HeaderPostCollectionReusableView else {
                return UICollectionReusableView()
            }
        
            if let settings = presenter?.postInfo(for: indexPath) {
                reusableview.settings = HeaderPostModel(postData: settings)
            }
            return reusableview
            
        default:  fatalError("Unexpected element kind")
        }
    }
}

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 45)
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
