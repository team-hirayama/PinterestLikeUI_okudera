//
//  PhotosData.swift
//  PinterestLikeApp
//
//  Created by OkuderaYuki on 2016/09/24.
//  Copyright © 2016年 yuoku. All rights reserved.
//

import UIKit

class PhotosData: NSObject {
    class func plistData(plistName: String) -> PhotosModel {
        var photosModel = PhotosModel()
        
        guard let plistPath = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist") else {
            return photosModel
        }
        guard let contentsOfFile = NSDictionary(contentsOfFile: plistPath) else {
            return photosModel
        }
        let photos = contentsOfFile.objectForKey("photos") as! NSArray
        if photos.count == 0 {
            return photosModel
        }
        
        for photo in photos {
            var photoModel = PhotoModel()
            photoModel.caption = photo["caption"] as! String
            photoModel.comment = photo["comment"] as! String
            photoModel.image = photo["image"] as! String
            
            photosModel.photos.append(photoModel)
        }
        
        return photosModel
    }
}
