//
//  TrendingCell.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/27/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
        APIService.shared.getTrendingData(completion: { mvideos in
            self.videos = mvideos
            self.collectionView.reloadData()
        })
    }
}
