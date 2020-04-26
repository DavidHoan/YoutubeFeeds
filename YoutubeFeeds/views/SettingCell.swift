//
//  SettingCell.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/24/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .lightGray : .white
            nameLabel.textColor  =  isHighlighted ? .white : .black
            iconImageView.tintColor  =  isHighlighted ? .white : .darkGray
        }
    }
    
    var setting:Setting? {
        didSet {
            nameLabel.text = setting?.name
            iconImageView.image = UIImage(named: (setting?.imageName)!)?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor  = .darkGray
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Settings"
        return label
    }()
    
    let iconImageView:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "more-icon-setting")
        img.contentMode  = ContentMode.scaleAspectFill
        return img
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(24)]-22-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:[v0(24)]", views: iconImageView)
        addConstraintsWithFormat(format: "V:|[v0(50)]", views: nameLabel)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: nameLabel, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
