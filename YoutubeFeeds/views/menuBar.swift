//
//  menuBar.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/23/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//

import UIKit

class menuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var homeController:HomeController?
    
    let menuColor:UIColor  =  UIColor.rgb(displayP3Red: 230, green: 32, blue: 31, alpha: 1)
    let cellId  = "cellId"
    let collectionViewHeight:CGFloat = 50
    
    let iconImages = ["menu1", "menu2", "menu3", "menu4"]
    
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = self.menuColor
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        //addConstraintsWithFormat(format: "V:[v0]|", views: collectionView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(h)]|", options: NSLayoutConstraint.FormatOptions(), metrics: ["h":collectionViewHeight], views: ["v0":collectionView]))
        
        backgroundColor = menuColor
        
        setupHorizontalBar()
    }
    
    var horizonBarLeftConstraint: NSLayoutConstraint?
    func setupHorizontalBar() {
        let horizontalView = UIView()
        horizontalView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalView)
        
        horizonBarLeftConstraint =  horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor)
        
        horizonBarLeftConstraint?.isActive = true
        //horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        horizontalView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        horizontalView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let x = CGFloat(indexPath.item) * frame.width/4
//        
//        horizonBarLeftConstraint?.constant = x
//        
//        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: { value in
//            
//        })
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
//        UIView.animate(withDuration: 0.3, animations: {
//            self.layoutIfNeeded()
//        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        //cell.backgroundColor = .blue
        cell.imageView.image = UIImage(named: iconImages[indexPath.item])!.withRenderingMode(.alwaysTemplate)
        cell.imageView.tintColor = UIColor.rgb(displayP3Red: 91, green: 14, blue: 13, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4, height: collectionViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}




