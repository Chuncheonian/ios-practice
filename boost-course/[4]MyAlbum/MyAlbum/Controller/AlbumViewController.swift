//
//  ViewController.swift
//  MyAlbum
//
//  Created by dykoon on 2021/09/15.
//

import UIKit
import Photos

class AlbumViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    // MARK: - Properties
    let imageManager: PHImageManager = PHImageManager.default()
    var albumModelList: [AlbumModel] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        authorizePhoto()
        setFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Configure()
    func configure() {
        albumCollectionView.dataSource = self
        albumCollectionView.delegate = self
        albumCollectionView.register(
            UINib(nibName: String(describing: AlbumCollectionViewCell.self), bundle: nil),
            forCellWithReuseIdentifier: "AlbumCollectionViewCell"
        )
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pictureListVC = segue.destination as? PictureListViewController else { return }
        guard let cell = sender as? AlbumCollectionViewCell else { return }
        guard let index = self.albumCollectionView.indexPath(for: cell) else { return }
        
        pictureListVC.albumModel = albumModelList[index.item]
    }
}

// MARK: - 사진접근권한 관련
extension AlbumViewController {
    
    func authorizePhoto() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가됨")
            self.requestCollection()
        case .denied:
            print("접근 불허")
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization { status in
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
        
        // PhotoLibrary가 변화될 때마다 delegate Method가 실행
//        PHPhotoLibrary.shared().register(self)
    }
    
    func requestCollection() {
        
        // AssetCollection 가져오기
        let cameraRollList: PHFetchResult<PHAssetCollection> =
            PHAssetCollection.fetchAssetCollections(
                with: .smartAlbum,
                subtype: .smartAlbumUserLibrary,
                options: nil
            )
        
        let favoritiesList: PHFetchResult<PHAssetCollection> =
            PHAssetCollection.fetchAssetCollections(
                with: .smartAlbum,
                subtype: .smartAlbumFavorites,
                options: nil
            )
        
        let albumList: PHFetchResult<PHAssetCollection> =
            PHAssetCollection.fetchAssetCollections(
                with: .album,
                subtype: .albumRegular,
                options: nil
            )
        // print(cameraRollList.count, favorities.count)  // > 1, 1, 3
        
        // AssetCollection에서 Asset 가져오기
        [cameraRollList, favoritiesList, albumList].forEach {
            $0.enumerateObjects { collection, _, _ in
                let albumTitle : String = collection.localizedTitle!
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]  // 생성시간순으로 정렬
                let assetsFetchResult: PHFetchResult = PHAsset.fetchAssets(in: collection, options: fetchOptions)
                self.albumModelList.append(AlbumModel(albumTitle: albumTitle, assetList: assetsFetchResult))
            }
        }
    }
}


// MARK: - UICollectionViewFlowLayout 관련
extension AlbumViewController {
    func setFlowLayout() {
        var flowLayout: UICollectionViewFlowLayout {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            flowLayout.minimumInteritemSpacing = 10  // item간 간격
            flowLayout.minimumLineSpacing = 25  // line간 간격
            flowLayout.itemSize = CGSize(width: 190, height: 239)  // 237 - 47 = 190
            
            return flowLayout
        }
    
        self.albumCollectionView.collectionViewLayout = flowLayout
    }
}


// MARK: - UICollectionViewDataSource
extension AlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumModelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: AlbumCollectionViewCell.self),
                for: indexPath) as? AlbumCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let asset = albumModelList[indexPath.item].assetList.object(at: 0)  // album안의 첫번째 사진 가져오기
        
        imageManager.requestImage(
            for: asset,
            targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight),
            contentMode: .aspectFill,
            options: nil
        ) { (image, _) in
            cell.imageView?.image = image
        }
        
        cell.titleLabel.text = albumModelList[indexPath.item].albumTitle
        cell.imageCountLabel.text = "\(albumModelList[indexPath.item].albumCount)"
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension AlbumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let pictureListVC = self.storyboard?.instantiateViewController(identifier: "pictureListVC") as? PictureListViewController else {
            return
        }
        
        pictureListVC.albumModel = albumModelList[indexPath.row]
        
        self.show(pictureListVC, sender: self)
    }
    
    
}

// MARK: - PHPhotoLibraryChangeObserver
//extension AlbumViewController: PHPhotoLibraryChangeObserver {
//
//    func photoLibraryDidChange(_ changeInstance: PHChange) {
//        for i in 0..<self.albumModelList.count {
//
//            if let changes = changeInstance.changeDetails(for: albumModelList[i].collection) {
//
//                if let changesMade = changes.objectAfterChanges {
//                    albumModelList[i].collection = changesMade
//                }
//                OperationQueue.main.addOperation {
//                    self.albumCollectionView.reloadSections(IndexSet(0...0))
//                }
//
//            }
//            OperationQueue.main.addOperation {
//                self.albumCollectionView.reloadSections(IndexSet(0...0))
//            }
//        }
//    }
//}
