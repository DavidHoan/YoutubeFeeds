//
//  extensionUIColor.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/23/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(displayP3Red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(displayP3Red: displayP3Red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

class extensionUIColor: NSObject {
    
}
