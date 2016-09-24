//
//  PhotoModel.swift
//  PinterestLikeApp
//
//  Created by OkuderaYuki on 2016/09/24.
//  Copyright © 2016年 yuoku. All rights reserved.
//

import UIKit

struct PhotoModel {
    var caption = ""
    var comment = ""
    var image = ""
}

struct PhotosModel {
    var photos = [PhotoModel]()
}
