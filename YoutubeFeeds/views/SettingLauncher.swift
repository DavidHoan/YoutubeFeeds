//
//  SettingLauncher.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/24/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit


class Setting: NSObject {
    var name:String = ""
    var imageName:String = ""
    
    init(name:SettingName, imageName:String) {
        self.name  = name.rawValue
        self.imageName  = imageName
    }
}

enum SettingName:String {
    case Setting = "Settings"
    case TermPriacy = "Term & Privacy policy"
    case Feed = "Send feedback"
    case Help = "Help"
    case SwitchAcc = "Switch account"
    case Cancel = "Cancel"
}

class SettingLauncher: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var homeController: HomeController?
    
    var blackView:UIView = UIView()
    
    let collectionView :UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    func showSettings() {
        if let window  = UIApplication.shared.keyWindow  {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissBlackView)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height:CGFloat = CGFloat(settings.count*50+20)
            let y = window.frame.height -  height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame  = CGRect(x: 0,y: y,width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }, completion: { value in
                print("done")
            })
        
        }
    }
    
    @objc func dismissBlackView(setting:Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            //self.collectionView.alpha = 0
            if let window  = UIApplication.shared.keyWindow  {
                self.collectionView.frame =  CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
            //self.blackView.alpha = 1
            //self.collectionView.frame  = CGRect(x: 0,y: self.collectionView.frame.height,width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            
        }, completion: { value in
            
            print("done  \(setting)")
            
            if !setting.isKind(of: UITapGestureRecognizer.self) {
                if setting.name != "" && setting.name != "Cancel" {
                    self.homeController?.showControllerForSetting(name: setting.name )
                }
            }
            
            //DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            //if setting != nil {
            
            //}
            
            
            //}
            
        })
    }
    
    let cellId = "cellId"
    let settings:[Setting] = {
        let setting = Setting(name: .Setting, imageName: "more-icon-setting")
        let term = Setting(name: .TermPriacy, imageName: "more-icon-key")
        let feedback = Setting(name: .Feed, imageName:"more-icon-setting-feedback")
        let help = Setting(name: .Help, imageName: "more-icon-help")
        let account = Setting(name: .SwitchAcc, imageName: "more-icon-account")
        let cancel = Setting(name: .Cancel, imageName: "more-icon-setting-cancel")
        return [setting, term, feedback, help, account, cancel]
    }()
    
    override init() {
        super.init()
        self.collectionView.delegate =  self
        self.collectionView.dataSource = self
        
        self.collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        
        let setting  = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("select \(settings[indexPath.item].name)")
        //dismissBlackView()
        
        //if let window  = UIApplication.shared.keyWindow  {
            //let height:CGFloat = CGFloat(settings.count*50+20)
            //let y = window.frame.height -  height
            
        dismissBlackView(setting: settings[indexPath.item])
        //}
        
        
    }
    
    
}
