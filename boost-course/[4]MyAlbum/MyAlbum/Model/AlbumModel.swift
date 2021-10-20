//
//  albumModel.swift
//  MyAlbum
//
//  Created by dykoon on 2021/09/16.
//

import Foundation
import Photos

struct AlbumModel {
    var albumTitle: String
    var assetList: PHFetchResult<PHAsset>
    
    var albumCount: Int {
        return assetList.count
    }
}
