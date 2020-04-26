//
//  videoCell.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/23/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews(){
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            print("didSet: \(video?.index ?? 1101)")
            
            titleLabel.text = video?.title
            
            thumbnailImageView.loadImgFromURLString(urlStr: video?.thumbnailImageName ?? "")
            
            userProfileImageView.loadImgFromURLString(urlStr: video?.channel?.profileImageName ?? "")
            
            let numberFormater = NumberFormatter()
            numberFormater.numberStyle = .decimal
            
            if let channelName  = video?.channel?.name, let numberOfView = video?.numberOfViews  {
                subtitleTextView.text = "\(channelName) - \( numberFormater.string(from: numberOfView) ?? "0") views - 2 years ago"
            }
            
            calculateTitleHeight()
        }
    }
    
    func calculateTitleHeight() {
        // get title Height
        if let title = video?.title {
            let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
            let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimateRect = NSString(string: title).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)], context: nil)
            if estimateRect.height > 20 {
                titleLabelHeightConstraint?.constant = 44
            } else {
                titleLabelHeightConstraint?.constant = 20
            }
        }
    }
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "") //taylor_swift
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "") //taylor_swift
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let sView = UIView()
        sView.backgroundColor = .lightGray
        //sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    let titleLabel:UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        //        title.backgroundColor = .purple
        title.numberOfLines = 2
        //title.text = "Taylor Swift - Blank Space"
        return title
    }()
    
    let subtitleTextView:UITextView = {
        let title = UITextView()
        title.translatesAutoresizingMaskIntoConstraints = false
        //title.translatesAutoresizingMaskIntoConstraints = true
        //title.backgroundColor = .red
        title.text = ""
        title.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        title.textColor = UIColor.lightGray
        title.isEditable = false
        title.isSelectable = false
        title.isScrollEnabled = false // keyword of do not display text in textView is here!
        return title
    }()
    
    override func setupViews() {
        //backgroundColor = .red
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addSubview(separatorView)
        
        //contentView.addSubview(subtitleTextView)
        
        
        /// constraint này khác so với trong demo - có thể nó dẫn đến việc menuBar ko pin vào viewController
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        // vertical constraint
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        
        // top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        // left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        // right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))

        // height constraint
        //addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
        
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint!)
        
        // subtitleTextView top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))

        // subtitleTextView left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))

        // subtitleTextView right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))

        // subtitleTextView height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
    
}
