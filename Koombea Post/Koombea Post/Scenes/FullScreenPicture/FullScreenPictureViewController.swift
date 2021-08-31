//
//  FullScreenPictureViewController.swift
//  Koombea Post
//
//  Created by Wilmer Mendoza on 29/8/21.
//

import UIKit

class FullScreenPictureViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK:- Vars
    var presenter: ViewToPresenterPictureProtocol?
    var viewTranslation = CGPoint(x: 0, y: 0)

    //MARK:- ViewController's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
        createBlur()
        blurView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    //MARK:- Settings
    func createBlur() {
        
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.bounds
        
        blurView.addSubview(visualEffectView)
    }
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .changed:
            
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
            
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                })
            } else {
                dismiss(animated: true, completion: nil)
            }
            
        default:
            break
        }
    }
}

//MARK:- Extensions
extension FullScreenPictureViewController: PresenterToViewPictureProtocol {
    
    func onFetchPictureSuccess(image: UIImage) {
        imageView.image = image
    }    
}
