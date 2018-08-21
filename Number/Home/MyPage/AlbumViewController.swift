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
        let navView = UIView()
        navView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height:             (self.navigationController?.navigationBar.frame.height)! + 20)
        navView.backgroundColor = UIColor.init(hex: "343ACF")
        view.addSubview(navView)
        
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
        return (self.fetchAlbum?.count)! + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! AlbumUICollectionViewCell
        
        if indexPath.row == 0 {
            //이미지 추가 ㄴ
            cell.imageView?.image = UIImage(named: "")
            let size = (view.frame.width - 10) / 5

            cell.imageView?.frame = CGRect(x: 0, y: 0, width: size, height: size)
            let button = UIButton()
            button.setTitle("button", for: .normal)
            button.frame = CGRect(x: 0, y: 0 , width: cell.imageView.frame.width, height: cell.imageView.frame.height)
            cell.inputView?.addSubview(button)
        }else {
            let asset : PHAsset = fetchAlbum.object(at: indexPath.row - 1)
            let size = (view.frame.width - 10) / 5
            
            imageManager.requestImage(for: asset,
                                      targetSize: CGSize(width: size, height: size),
                                      contentMode: .aspectFill,
                                      options: nil,
                                      resultHandler: {image, _ in
                                        cell.imageView?.image = image
                            
            })
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //사진 선택했을때 전송하기
        self.dismiss(animated: true, completion: nil)
        print(self.fetchAlbum[indexPath.row - 1])
        
    }
}
 
 extension AlbumViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        let size = (view.frame.width - 20) / 5
        
        return CGSize(width: size, height: size)
    }
 }
 

