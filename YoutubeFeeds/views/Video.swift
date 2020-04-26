//
//  Video.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/23/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnailImageName: String?
    var title: String?
    var detail: String?
    var index:Int = 0
    
    var numberOfViews:NSNumber?
    var uploadDate:NSDate?
    
    var channel:Channel?
}

class Channel: NSObject {
    var name:String?
    var profileImageName:String?
}
