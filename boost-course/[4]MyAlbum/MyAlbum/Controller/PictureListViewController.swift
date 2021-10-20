//
//  PictureListViewController.swift
//  MyAlbum
//
//  Created by dykoon on 2021/09/17.
//

import UIKit
import Photos

class PictureListViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var pictureCollectionView: UICollectionView!
    
    // MARK: - Properties
    var albumModel: AlbumModel?
    let imageManager: PHImageManager = PHImageManager.default()
    let itemSize = (UIScreen.main.bounds.width - 24) / 3.0
    var deleteItemIndexList = [Int]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureCollectionView.dataSource = self
        pictureCollectionView.delegate = self
        self.navigationItem.title = albumModel?.albumTitle
        
        setFlowLayout()

        PHPhotoLibrary.shared().register(self)
    }
    
    // MARK: - FlowLayout
    func setFlowLayout() {
        var flowLayout: UICollectionViewFlowLayout {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets.zero
            flowLayout.minimumInteritemSpacing = 12  // item간 간격
            flowLayout.minimumLineSpacing = 12  // line간 간격
            flowLayout.itemSize = CGSize(width: itemSize, height: itemSize)
            
            return flowLayout
        }
    
        self.pictureCollectionView.collectionViewLayout = flowLayout
    }
    
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func selectButtonPressed(_ sender: UIBarButtonItem) {
        self.pictureCollectionView.allowsMultipleSelection = true
    }
    
    
    @IBAction func trashbuttonPressed(_ sender: Any) {
//        var assetList: [PHAsset] = []
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let pictureVC = segue.destination as? PictureViewController else { return }
        guard let cell = sender as? PictureListCollectionViewCell else { return }
        guard let index = self.pictureCollectionView.indexPath(for: cell) else { return }
        
        pictureVC.asset = albumModel?.assetList[index.item]
    }
}

// MARK: - UICollectionViewDataSource
extension PictureListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumModel?.albumCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as? PictureListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let asset = albumModel?.assetList.object(at: indexPath.item) else {
            return UICollectionViewCell()
        }
        
        imageManager.requestImage(
            for: asset,
            targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight),
            contentMode: .aspectFill,
            options: nil
        ) { (image, _) in
            cell.pictureImageView.image = image
            cell.pictureImageView.contentMode = .scaleAspectFill
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PictureListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//
//        guard let pictureListVC = self.storyboard?.instantiateViewController(identifier: "pictureListVC") as? PictureListViewController else {
//            return
//        }
//
//        pictureListVC.albumModel = albumModelList[indexPath.row]
//
//        self.show(pictureListVC, sender: self)
    }

//    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
//        <#code#>
//    }

}

// MARK: - PHPhotoLibraryChangeObserver
extension PictureListViewController: PHPhotoLibraryChangeObserver {

    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let changes = changeInstance.changeDetails(for: albumModel!.assetList) else {
            return
        }
        
        albumModel?.assetList = changes.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.pictureCollectionView.reloadData()
        }

    
    }
}
