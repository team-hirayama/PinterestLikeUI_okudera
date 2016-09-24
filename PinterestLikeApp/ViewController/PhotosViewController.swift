//
//  PhotosViewController.swift
//  PinterestLikeApp
//
//  Created by OkuderaYuki on 2016/09/24.
//  Copyright © 2016年 yuoku. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photosModel = PhotosModel()
    
    let imageCollectionViewLayout = ImageCollectionViewLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        let plistName = "photos"
        photosModel = PhotosData.plistData(plistName)
        
        collectionView.collectionViewLayout = imageCollectionViewLayout
        
        imageCollectionViewLayout.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosModel.photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        cell.imageView.image = UIImage(named: "\(photosModel.photos[indexPath.row].image)" + ".jpeg")
        cell.captionLabel.text = photosModel.photos[indexPath.row].caption
        cell.commentLabel.text = photosModel.photos[indexPath.row].comment
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // TODO: 画面遷移実装
        print("selected")
    }
}

// MARK: - ImageCollectionViewLayout
extension PhotosViewController: ImageCollectionViewLayoutDelegate {
    
    func heightForImageAtIndexPath(collectionView :UICollectionView,indexPath :NSIndexPath,width :CGFloat) -> CGFloat {
        if let image = UIImage(named: "\(photosModel.photos[indexPath.row].image)" + ".jpeg") {
            return ImageCollectionViewCell.imageHeightWithImage(image, cellWidth: width)
        }
        return 0.0
    }
    
    func heightForBodyAtIndexPath(collectionView :UICollectionView,indexPath :NSIndexPath,width :CGFloat) -> CGFloat {
        return ImageCollectionViewCell.bodyHeightWithText(photosModel.photos[indexPath.row].caption, commentText: photosModel.photos[indexPath.row].comment, cellWidth: width)
    }
}