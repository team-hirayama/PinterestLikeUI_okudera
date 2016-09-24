//
//  ImageCollectionViewLayout.swift
//  PinterestLikeApp
//
//  Created by OkuderaYuki on 2016/09/24.
//  Copyright © 2016年 yuoku. All rights reserved.
//

import UIKit

protocol ImageCollectionViewLayoutDelegate {
    func heightForImageAtIndexPath(collectionView: UICollectionView,indexPath: NSIndexPath,width: CGFloat) -> CGFloat
    func heightForBodyAtIndexPath(collectionView: UICollectionView,indexPath: NSIndexPath,width: CGFloat) -> CGFloat
}

class ImageCollectionViewLayout: UICollectionViewLayout {
    
    let numberOfColumns = 2
    let cellMargin: CGFloat = 10.0
    var delegate: ImageCollectionViewLayoutDelegate! = nil
    var cachedAttributes: Array<UICollectionViewLayoutAttributes> = [];
    var contentHeight: CGFloat = 0.0
    
    private func contentWidth() -> CGFloat {
        return CGRectGetWidth(self.collectionView!.bounds) - (self.collectionView!.contentInset.left + self.collectionView!.contentInset.right)
    }
    
    // MARK: - UICollectionViewLayout
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(contentWidth(), contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: Array<UICollectionViewLayoutAttributes> = []
        
        for attribute in cachedAttributes {
            if (CGRectIntersectsRect(attribute.frame, rect)) {
                layoutAttributes.append(attribute)
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cachedAttributes[indexPath.item]
    }
    
    override func prepareLayout() {
        // レイアウト情報をキャッシュ済みの場合はリターン
        if self.cachedAttributes.count > 0 {
            return;
        }
        
        var column = 0
        
        // 幅
        let totalHorizontalMargin: CGFloat = (cellMargin * (CGFloat(numberOfColumns - 1)))
        let cellWidth: CGFloat = (contentWidth() - totalHorizontalMargin) / CGFloat(numberOfColumns)
        
        var cellOriginXList = Array<CGFloat>()
        for i in 0..<numberOfColumns {
            let originX: CGFloat  = CGFloat(i)*(cellWidth + cellMargin)
            cellOriginXList.append(originX)
        }
        var currentCellOriginYList: Array<CGFloat> = Array<CGFloat>()
        for _ in 0..<numberOfColumns {
            currentCellOriginYList.append(0.0)
        }
        
        // サイズ,座標
        for item in 0..<self.collectionView!.numberOfItemsInSection(0) {
            let indexPath : NSIndexPath = NSIndexPath(forRow: item, inSection: 0)
            
            // セルのイメージ部・テキスト部の高さ
            let imageHeight: CGFloat  = self.delegate.heightForImageAtIndexPath(
                self.collectionView!, indexPath: indexPath, width: cellWidth)
            
            let bodyHeight: CGFloat  = self.delegate.heightForBodyAtIndexPath(
                self.collectionView!, indexPath: indexPath, width: cellWidth)
            let cellHeight: CGFloat  = imageHeight + bodyHeight + 50
            
            let cellFrame: CGRect = CGRectMake(cellOriginXList[column],
                                               currentCellOriginYList[column],
                                               cellWidth,
                                               cellHeight)
            
            let attributes = ImageCollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            attributes.imageHeight = imageHeight
            attributes.frame = cellFrame;
            self.cachedAttributes.append(attributes)
            
            self.contentHeight = max(contentHeight, CGRectGetMaxY(cellFrame))
            
            // 次のセル
            currentCellOriginYList[column] = currentCellOriginYList[column] + cellHeight + cellMargin
            
            // 次のカラム
            var nextColumn: Int = 0
            var minOriginY: CGFloat = CGFloat.max
            let nsCurrentCellOriginYList: NSArray = NSArray(array: currentCellOriginYList)
            nsCurrentCellOriginYList.enumerateObjectsUsingBlock({ originY, index, stop in
                if (originY.compare(minOriginY) == .OrderedAscending) {
                    minOriginY = CGFloat(originY as! NSNumber)
                    nextColumn = index;
                }
            })
            
            column = nextColumn;
        }
    }
}

