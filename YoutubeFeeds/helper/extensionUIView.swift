//
//  extensionUIView.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/23/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit


extension UIView {
    
    func addConstraintsWithFormat(format:String, views: UIView...) {
        var viewsDictionary =  [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"  // tên view sẽ có chữ v && số index 0,1,2...
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    //    func addConstraintsWithFormat(format:String, metrics:[String: Any] = [:], views: UIView...) {
    //        var viewsDictionary =  [String: UIView]()
    //        for (index, view) in views.enumerated() {
    //            let key = "v\(index)"  // tên view sẽ có chữ v && số index 0,1,2...
    //            view.translatesAutoresizingMaskIntoConstraints = false
    //            viewsDictionary[key] = view
    //        }
    //
    //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: viewsDictionary))
    //    }
}

extension UILabel  {
    func height() -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        //let currentFontSize = self.font.pointSize
        //var currentFontName = self.font.fontName
        
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        return label.frame.height
    }
}


class extensionUIView: NSObject {

}
