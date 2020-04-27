//
//  extensions.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/23/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func upperCaseFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func upperCaseFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UIImageView {
    func loadImgFromURLString(urlStr:String  = "") {
        
        guard let murl = URL(string: urlStr) else {
                return
            }
            
            URLSession.shared.dataTask(with: murl, completionHandler: {(data, response, e) in
                print("response \(String(describing: response))")
                DispatchQueue.main.async {
                    self.image = UIImage(data: data ?? Data())
                }
            }).resume()
        }
    
}

extension UIBarButtonItem {
    
    static func menuButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        
        let Image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal) //nav-menu-vertical
        
        button.setImage(Image, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        //let testButton : UIButton = UIButton.init(type: .custom)
        //testButton.setImage(editImage, for: .normal)
        //testButton.addTarget(self, action: #selector(didTapCameraButton), for: .touchUpInside)
        //button.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        //let addButton = UIBarButtonItem(customView: testButton)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
//        menuBarItem.customView?.rightAnchor.constraint(equalTo: self.view, constant: <#T##CGFloat#>)
//        menuBarItem.customView?.rightAnchor.constraint(equalTo:  , constant: -20)
        
        return menuBarItem
    }
}
