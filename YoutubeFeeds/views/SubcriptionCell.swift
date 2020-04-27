//
//  SubcriptionCell.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/27/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit

class SubcriptionCell: FeedCell {
    override func fetchVideos() {
        APIService.shared.getSubcriptionData(completion: { mvideos in
            self.videos = mvideos
            self.collectionView.reloadData()
        })
    }
}
