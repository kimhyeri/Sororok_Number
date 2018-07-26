 //
//  AlbumViewController.swift
//  Number
//
//  Created by hyerikim on 2018. 7. 27..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import UIKit
import Photos

 class AlbumViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collecionView: UICollectionView!
    
    var fetchAlbum : PHFetchResult<PHAsset>!
    let imageManager : PHCachingImageManager = PHCachingImageManager()
    let cellIdentifier : String = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collecionView.dataSource = self
        collecionView.delegate = self
        
        let photoAuthorizationSatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationSatus {
        case .authorized:
            self.requestAlbum()
            self.collecionView.reloadData()
        case .denied:
            print("nono")
        case .notDetermined:
            print("아직 응답 ㄴ")
            PHPhotoLibrary.requestAuthorization({(status) in
                switch status{
                case .authorized:
                    self.requestAlbum()
                    OperationQueue.main.addOperation {
                        self.collecionView.reloadData()
                    }
                case .denied:
                    print("no")
                default: break
                }
            })
        case .restricted:
            print("접근 제한")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestAlbum(){
        let camera: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        guard let cameraRollCollection = camera.firstObject else{
            return
        }
        
        let fetchOpions = PHFetchOptions()
        fetchOpions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchAlbum = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOpions)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchAlbum?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! AlbumUICollectionViewCell
        
        let asset : PHAsset = fetchAlbum.object(at: indexPath.row)
        
        imageManager.requestImage(for: asset,
                                  targetSize: CGSize(width: 50, height: 50),
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: {image, _ in
                                    cell.imageView?.image = image
            
        })
        return cell
    }
}
 

