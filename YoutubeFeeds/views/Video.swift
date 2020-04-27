//
//  Video.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/23/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    @objc var thumbnail_image_name: String?
    @objc var title: String?
    //@objc var duration:NSNumber?
    @objc var number_of_views:NSNumber?
    
    @objc var channel:Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
    
        /// bỏ qua các property(var) không có trong class mà có ở Dictionary
        /// => ví dụ bỏ cái var duration:NSNumber? đi mà ko bị CRASH
        
        let selectorString = key.upperCaseFirstLetter()
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let response = self.responds(to: selector)
        
        if !response {
            return
        }
        
        if key == "channel" {
            channel =  Channel()
            channel?.setValuesForKeys(value as! [String:Any])
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    
    /// Data format
    
    //    "title":"Everything Wrong with Zootopia",
    //    "number_of_views":319644991,
    //    "thumbnail_image_name":"https://s3-us-west-2.amazonaws.com/youtubeassets/zootopia.png",
    //    "channel":{
    //    "name":"CinemaSins",
    //    "profile_image_name":"https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_fan_forever_profile.jpg"
    //    },
    //    "duration":210
    
}

@objcMembers
class Channel: NSObject {
    var name:String?
    var profile_image_name:String?
    
    //"profile_image_name" : "https:\/\/s3-us-west-2.amazonaws.com\/youtubeassets\/taylor_fan_forever_profile.jpg",
    //"name" : "Taylor Fan Forever"
}
