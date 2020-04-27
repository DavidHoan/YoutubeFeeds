//
//  ProfileCell.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/27/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit

class ProfileCell: FeedCell {
    override func fetchVideos() {
        APIService.shared.getTrendingData(completion: { mvideos in
            self.videos = [Video]()
            self.collectionView.reloadData()
        })
    }
}
