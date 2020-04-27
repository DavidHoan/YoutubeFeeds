//
//  APIService.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/27/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit
import SwiftyJSON

class APIService: NSObject {
    static let shared = APIService()
    
    func getFileData(filename: String, completionHandle:@escaping ([Video]) -> ()) {
        let json = readJsonFile(filename: filename)
//        var mvideos = [Video]()
//        for (index, item) in json.arrayValue.enumerated()  {
//            print("\(index) - item: \(item)")
////            let mvideo = Video()
////            let mdata = item.dictionaryObject!
////            mvideo.setValuesForKeys(mdata)
//            if let iitem:[String:Any] = item.dictionaryObject {
//                mvideos.append(Video(dict: iitem))
//            }
//            
//        }
//        //return mvideos
//        print(json.arrayValue.map({
//            print("json.arrayValue - item: \($0)")
//        }))
        DispatchQueue.main.async {
            completionHandle(json.arrayValue.map({ return Video(dict: $0.dictionaryObject!) }))
            //completionHandle(json.map({return Video(dict: $0.dictionaryObject)}))
        }
    }
        
    func getSubcriptionData(completion:@escaping ([Video]) -> ()) {
        
        getFileData(filename: "subscriptions", completionHandle: { videos in
            completion(videos)
        })
        
//        let json = readJsonFile(filename: "subscriptions")
//        var mvideos = [Video]()
//        for (index, item) in json.arrayValue.enumerated()  {
//            print("\(index) - item: \(item)")
//            let mvideo = Video()
//            let mdata = item.dictionaryObject!
//            mvideo.setValuesForKeys(mdata)
//
//            mvideos.append(mvideo)
//        }
//        //return mvideos
//
//        DispatchQueue.main.async {
//            completion(mvideos)
//        }
        
    }
    
    func getTrendingData(completion:@escaping ([Video]) -> ()) {
        
        getFileData(filename: "trending", completionHandle: { videos in
            completion(videos)
        })
        
//        let json = readJsonFile(filename: "trending")
//        var mvideos = [Video]()
//        for (index, item) in json.arrayValue.enumerated()  {
//            print("\(index) - item: \(item)")
//
//            //let mvideo = Video(dict: item.dictionaryObject!)
//            //let mdata = item.dictionaryObject!
//            //mvideo.setValuesForKeys(mdata)
//
////            let keynalChannel = Channel()
////            keynalChannel.name  = item["channel"]["name"].stringValue
////            keynalChannel.profile_image_name = item["channel"]["profile_image_name"].stringValue
////
////            let mvideo = Video()
////            mvideo.title = item["title"].stringValue
////            mvideo.thumbnail_image_name = item["thumbnail_image_name"].stringValue
////            mvideo.channel = keynalChannel
////            mvideo.number_of_views = item["profile_image_name"].numberValue
//
//            mvideos.append(Video(dict: item.dictionaryObject!))
//        }
//        //return mvideos
//
//        DispatchQueue.main.async {
//            completion(mvideos)
//        }
        
    }
    
    func getHomeData(completion:@escaping ([Video]) -> ()) {
        
        getFileData(filename: "home", completionHandle: { videos in
            completion(videos)
        })
        
//        let json = readJsonFile(filename: "home")
//        var mvideos = [Video]()
//        for (index, item) in json.arrayValue.enumerated()  {
//            print("\(index) - item: \(item)")
//
//            //let mvideo = Video()
//            //let mdata = item.dictionaryObject!
//            //mvideo.setValuesForKeys(mdata)
//
////            let keynalChannel = Channel()
////            keynalChannel.name  = item["channel"]["name"].stringValue
////            keynalChannel.profile_image_name = item["channel"]["profile_image_name"].stringValue
////
////            let mvideo = Video()
////            mvideo.title = item["title"].stringValue
////            mvideo.thumbnail_image_name = item["thumbnail_image_name"].stringValue
////            mvideo.channel = keynalChannel
////            mvideo.number_of_views = item["profile_image_name"].numberValue
//
//            mvideos.append(Video(dict: item.dictionaryObject!))
//        }
//        //return mvideos
//
//        DispatchQueue.main.async {
//            completion(mvideos)
//        }
        
    }
    
    func readJsonFile(filename:String) -> JSON{
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                //print("jsonData:\(jsonObj)")
                return jsonObj
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                return JSON()
            }
        } else {
            print("Invalid filename/path.")
            return JSON()
        }
    }
}
