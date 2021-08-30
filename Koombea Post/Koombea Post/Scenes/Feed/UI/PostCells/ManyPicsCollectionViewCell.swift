//
//  ManyPicsCollectionViewCell.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 29/8/21.
//

import UIKit

class ManyPicsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let reuseIdentifier = "ManyPicsCollectionViewCellId"
    
    weak var delegate: ImageSelectecion?
    
    var picsDataSource = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        settingCollectionView()
        settingImageView()
    }

    private struct Constants {
        static let cellNibName = "PicCollectionViewCell"
        static let spaceBetweenItems: CGFloat = 10
        static let cellHeight: CGFloat = 54
    }
    
    var settings: PostCellModel? {
        
        didSet {
            
            dateLabel.text = settings?.post.datePost
            mainImageView.loadImageFrom(url: settings?.post.postImageUrl[0] ?? "")
            
            picsDataSource = settings?.post.postImageUrl ?? []
            picsDataSource.remove(at: 0)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK:- Settings
    private func settingCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: Constants.cellNibName, bundle: nil),
                                forCellWithReuseIdentifier: PicCollectionViewCell.reuseIdentifier)
    }
    
    private func settingImageView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(fisrtPicImageViewTapped))
        tap.numberOfTapsRequired = 1
                
        mainImageView.addGestureRecognizer(tap)
    }
    
    @objc func fisrtPicImageViewTapped() {
        delegate?.openImage(image: mainImageView.image)
    }
}

extension ManyPicsCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        picsDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicCollectionViewCell.reuseIdentifier, for: indexPath) as? PicCollectionViewCell else { fatalError("com_koobea_post_error_deque_cell".localized())
        }
        
        cell.imageUrl = picsDataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PicCollectionViewCell, let image = cell.imageView.image else {return}
        
        delegate?.openImage(image: image)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenItems
    }
}
