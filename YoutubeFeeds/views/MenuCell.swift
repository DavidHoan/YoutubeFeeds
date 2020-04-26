//
//  MenuCell.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/23/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "menu1")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(displayP3Red: 91, green: 14, blue: 13, alpha: 1)
        return iv
    }()
    
//    override var isHighlighted: Bool {
//        didSet {
//            print("123123s")
//            imageView.tintColor  = isHighlighted ? .white : UIColor.rgb(displayP3Red: 91, green: 14, blue: 13, alpha: 1)
//        }
//    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor  = isSelected ? .white : UIColor.rgb(displayP3Red: 91, green: 14, blue: 13, alpha: 1)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "H:[v0(24)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(24)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
