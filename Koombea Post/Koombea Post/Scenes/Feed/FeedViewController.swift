//
//  PostFeedViewController.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 28/8/21.
//

import UIKit
import SkeletonView
import Kingfisher

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
        static let headerCollectionView = "HeaderPostCollectionReusableView"
        static let singlePostCellNibName = "SinglePostCollectionViewCell"
        static let twoPicsCellNibName = "TwoPicsCollectionViewCell"
        static let threePicsCellNibName = "ThreePicsCollectionViewCell"
        static let manyPicsCellNibName = "ManyPicsCollectionViewCell"
        static let headerHeight: CGFloat = 45
        static let spaceBetweenRows: CGFloat = 10
    }
    
    //MARK:- ViewController's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        settingCollectionView()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        postCollectionView.isSkeletonable = true
        postCollectionView.showGradientSkeleton()
        postCollectionView.showSkeleton(usingColor: .wetAsphalt, transition: .crossDissolve(0.5))
    }
    
    //MARK:- Settings
    func settingCollectionView() {
        
        postCollectionView.addSubview(refreshControl)
        postCollectionView.register(UINib.init(nibName: Constants.headerCollectionView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPostCollectionReusableView.reeuseIdentifier)
        postCollectionView.register(UINib(nibName: Constants.singlePostCellNibName, bundle: nil),
                                    forCellWithReuseIdentifier: SinglePostCollectionViewCell.reuseIdentifier)
        postCollectionView.register(UINib(nibName: Constants.twoPicsCellNibName, bundle: nil),
                                    forCellWithReuseIdentifier: TwoPicsCollectionViewCell.reuseIdentifier)
        postCollectionView.register(UINib(nibName: Constants.threePicsCellNibName, bundle: nil),
                                    forCellWithReuseIdentifier: ThreePicsCollectionViewCell.reuseIdentifier)
        postCollectionView.register(UINib(nibName: Constants.manyPicsCellNibName, bundle: nil),
                                    forCellWithReuseIdentifier: ManyPicsCollectionViewCell.reuseIdentifier)
    }
    
    // MARK: - Actions
     @objc func refresh() {
        presenter?.refresh()
        postCollectionView.showGradientSkeleton()
     }
}

//MARK:- Extension
extension FeedViewController: PresenterToViewFeedProtocol {
    
    func onFetchFeedSuccess() {
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.postCollectionView.reloadData()
            self.postCollectionView.hideSkeleton()
        }
    }
    
    func onFecthFeedFailure(with error: ServiceErrors) {
        DispatchQueue.main.async {
            self.postCollectionView.hideSkeleton()
            self.refreshControl.endRefreshing()
            self.presenter?.showAlertError(title: "Error", message: error.rawValue.localized())
        }
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

extension FeedViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
                    
        return SinglePostCollectionViewCell.reuseIdentifier
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRows(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        guard let typeCell = presenter?.getTypeCell(for: indexPath) else { fatalError("com_koobea_post_error_deque_cell".localized()) }

        switch typeCell {
        
        case .singlePic:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SinglePostCollectionViewCell.reuseIdentifier, for: indexPath) as? SinglePostCollectionViewCell else { fatalError("com_koobea_post_error_deque_cell".localized())
            }
            
            if let post = presenter?.getPostForRow(for: indexPath) {
                cell.settings = PostCellModel(postData: post)
            }
            
            cell.delegate = self
            
            return cell
            
        case .twoPics:
        
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TwoPicsCollectionViewCell.reuseIdentifier, for: indexPath) as? TwoPicsCollectionViewCell else { fatalError("com_koobea_post_error_deque_cell".localized())
            }
            
            if let post = presenter?.getPostForRow(for: indexPath) {
                cell.settings = PostCellModel(postData: post)
            }
            
            cell.delegate = self
            return cell

        case .threPics:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreePicsCollectionViewCell.reuseIdentifier, for: indexPath) as? ThreePicsCollectionViewCell else { fatalError("com_koobea_post_error_deque_cell".localized())
            }
            
            if let post = presenter?.getPostForRow(for: indexPath) {
                cell.settings = PostCellModel(postData: post)
            }
            
            cell.delegate = self
            return cell
            
        case .moreThanThreePics:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ManyPicsCollectionViewCell.reuseIdentifier, for: indexPath) as? ManyPicsCollectionViewCell else { fatalError("com_koobea_post_error_deque_cell".localized())
            }
        
            if let post = presenter?.getPostForRow(for: indexPath) {
            cell.settings = PostCellModel(postData: post)
            }
            
            cell.delegate = self
            return cell
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: Constants.headerHeight)
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let typeCell = presenter?.getTypeCell(for: indexPath)
        
        switch typeCell {
        case .singlePic:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.4)

        case .twoPics:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.25)

        default:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.78)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }
}

extension FeedViewController: ImageSelectecion {
    
    func openImage(image: UIImage?) {
        
        guard let image = image else {return}
        presenter?.presentInFullScreen(image: image)
    }
}
