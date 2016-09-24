//
//  ImageCollectionViewCell.swift
//  PinterestLikeApp
//
//  Created by OkuderaYuki on 2016/09/24.
//  Copyright © 2016年 yuoku. All rights reserved.
//

import UIKit
import AVFoundation

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    // イメージ部
    class func imageHeightWithImage(image: UIImage, cellWidth: CGFloat) -> CGFloat {
        let boundingRect: CGRect  =  CGRectMake(0, 0, cellWidth, CGFloat.max)
        let rect: CGRect = AVMakeRectWithAspectRatioInsideRect(image.size, boundingRect)
        
        return rect.size.height;
    }
    
    // テキスト部
    class func bodyHeightWithText(captionText: String, commentText: String, cellWidth: CGFloat) -> CGFloat {
        let padding: CGFloat = 4.0
        let width: CGFloat = (cellWidth - padding * 2)
        let font = UIFont.systemFontOfSize(14.0)
        let attributes = [NSFontAttributeName:font]
        
        let captionRect: CGRect = (captionText as NSString).boundingRectWithSize(CGSizeMake(width, CGFloat.max),
                                                                   options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                                   attributes: attributes,
                                                                   context: nil)
        
        let commentRect: CGRect = (commentText as NSString).boundingRectWithSize(CGSizeMake(width, CGFloat.max),
                                                                                 options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                                                 attributes: attributes,
                                                                                 context: nil)
        
        return padding + ceil(captionRect.size.height) + ceil(commentRect.size.height) + padding
    }

}
