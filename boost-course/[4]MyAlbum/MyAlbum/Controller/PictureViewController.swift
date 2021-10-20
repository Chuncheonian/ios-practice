//
//  PictureViewController.swift
//  MyAlbum
//
//  Created by dykoon on 2021/09/17.
//

import UIKit
import Photos

class PictureViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    var asset: PHAsset!
    let imageManager: PHImageManager = PHCachingImageManager.default()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.contentSize = imageView.frame.size
        imageView.contentMode = .scaleAspectFit
        
        imageManager.requestImage(
            for: asset,
            targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight),
            contentMode: .aspectFill,
            options: nil
        ) { image, _ in
            self.imageView.image = image
        }
    }

    @IBAction func trashButtonPressed(_ sender: UIBarButtonItem) {
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.deleteAssets([self.asset!] as NSArray)
        } completionHandler: { success, error in
            if success == true {
                OperationQueue.main.addOperation {
                    self.navigationController?.popViewController(animated: false)
                }
            }
        }
    }
}

extension PictureViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
