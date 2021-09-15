//
//  ImageZoomViewController.swift
//  PhotosExample
//
//  Created by dykoon on 2021/09/15.
//

import UIKit
import Photos

class ImageZoomViewController: UIViewController {

    var asset: PHAsset!
    let imagemanager: PHCachingImageManager = PHCachingImageManager()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        scrollView.delegate = self
        
        imagemanager.requestImage(for: asset,
                                  targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight),
                                  contentMode: .aspectFill,
                                  options: nil
                                ) { image, _ in
                                    self.imageView.image = image
        }
    }

}


extension ImageZoomViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
