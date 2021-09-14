//
//  ViewController.swift
//  PhotosExample
//
//  Created by dykoon on 2021/09/13.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier: String = "cell"
    
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()  // 앨범에서 사진 받아오기 위한 객체
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가됨")
            self.requestCollection()
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        case .denied:
            print("접근 불허")
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    print("사용자가 허가함")
                    self.requestCollection()
                case .denied:
                    print("사용자가 불허함")
                default:
                    break
                }
            }
        case .restricted:
            print("접근 제한")
        default:
            break
        }
        
        PHPhotoLibrary.shared().register(self)
    }
    
    func requestCollection() {
        
        let cameraRoll: PHFetchResult<PHAssetCollection> =
            PHAssetCollection.fetchAssetCollections(
                with: .smartAlbum,
                subtype: .smartAlbumUserLibrary,
                options: nil
            )
        
        guard let cameraRollCollection = cameraRoll.firstObject else { return }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let asset: PHAsset = fetchResult.object(at: indexPath.row)
        
        imageManager.requestImage(for: asset,
                                targetSize: CGSize(width: 30, height: 30),
                                contentMode: .aspectFill,
                                options: nil) { image, _ in
                                    cell.imageView?.image = image
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    // row를 편집가능하게 만듦
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let asset: PHAsset = self.fetchResult[indexPath.row]
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.deleteAssets([asset] as NSArray)
            }, completionHandler: nil)
        }
    }
    
}


// MARK: - PHPhotoLibraryChangeObserver
extension ViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult) else {
            return
        }
        
        fetchResult = changes.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        }
    }
}
