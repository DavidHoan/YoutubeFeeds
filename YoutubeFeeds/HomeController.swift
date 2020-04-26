//
//  ViewController.swift
//  YoutubeFeeds
//
//  Created by Dong on 4/22/20.
//  Copyright © 2020 3bgroup. All rights reserved.
//



import UIKit
import SwiftyJSON

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos:[Video] = {
        
        var keynalChannel = Channel()
        keynalChannel.name  = "KeynalIsTheBestChannel"
        keynalChannel.profileImageName = "youtuber_avatar"
        
        var blankSpaceVideo = Video()
        blankSpaceVideo.title = "Taylor Swift - Blank Space"
        blankSpaceVideo.thumbnailImageName = "taylor_swift"
        //blankSpaceVideo.detail = "Taylor Swift VEVO - Blank Space - 1,604,208 views - 2 years ago."
        blankSpaceVideo.channel = keynalChannel
        blankSpaceVideo.numberOfViews = 1424567098
        
        var badBloodVideo = Video()
        badBloodVideo.title = "Taylor Swift - Bad Blood where human fight to live every day."
        badBloodVideo.thumbnailImageName = "taylor_swift1"
        //badBloodVideo.detail = "Taylor Swift VEVO -  Bad Blood - 2,622,507 views - 3 years ago."
        badBloodVideo.channel = keynalChannel
        badBloodVideo.numberOfViews = 29887375233
        
        return []
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHomeData()
        
        //navigationItem.title = "Home"
//        navigationController?.hidesBarsOnSwipe = true
        
        //navigationController?.navigationBar.barTintColor = UIColor.rgb(displayP3Red: 230, green: 32, blue: 31, alpha: 1)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        //navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleLabel.text = "Home"
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
  
        collectionView.backgroundColor = .white
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavBarButtons()

    }
    
    func getHomeData() {
        let json = readJsonFile()
        
        for (index, item) in json.arrayValue.enumerated()  {
            print("\(index) - item: \(item)")
            
            let keynalChannel = Channel()
            keynalChannel.name  = item["channel"]["name"].stringValue
            keynalChannel.profileImageName = item["channel"]["profile_image_name"].stringValue
            
            let mvideo = Video()
            mvideo.title = item["title"].stringValue
            mvideo.thumbnailImageName = item["thumbnail_image_name"].stringValue
            mvideo.channel = keynalChannel
            mvideo.numberOfViews = item["profile_image_name"].numberValue
            
            videos.append(mvideo)
        }
    }
    
    func setupNavBarButtons() {

        let searchBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(handleSearchAction), imageName: "nav-search")
        
        let menuBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(handleMenuAction), imageName: "nav-menu-vertical")
        
        
        //let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //navigationItem.rightBarButtonItems = [menuBarButtonItem, spacer, searchBarButtonItem]
        
        navigationItem.rightBarButtonItems = [menuBarButtonItem, searchBarButtonItem]
        
    }
    
    @objc func handleSearchAction() {
        print(123)
    }
    
    lazy var launchSettings = SettingLauncher()
    
    @objc func handleMenuAction() {
        launchSettings.homeController = self
        launchSettings.showSettings()
    }
    
    @objc func showControllerForSetting(name: String) {
        let dummySettingViewController  = UIViewController()
        dummySettingViewController.navigationItem.title = name
        dummySettingViewController.view.backgroundColor = .white
        dummySettingViewController.navigationController?.navigationBar.barTintColor = UIColor.rgb(displayP3Red: 230, green: 32, blue: 31, alpha: 1)
        navigationController?.pushViewController(dummySettingViewController, animated: true)
    }
    
    let menubar: menuBar  = {
        let mnb  = menuBar()
        return mnb
    }()
    
    
    func setupMenuBar() {
        view.addSubview(menubar)
        
        print("navigationItem.titleView :: \(String(describing: self.topbarHeight))")
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menubar)
        //view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menubar)
        
        //view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(topY)]", options: NSLayoutConstraint.FormatOptions(), metrics: ["topY":self.topbarHeight+50], views: ["v0":menubar]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-topY-[v0(50)]", options: NSLayoutConstraint.FormatOptions(), metrics: ["topY":self.topbarHeight], views: ["v0":menubar]))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        
        menubar.collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        //menubar.collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        //var darkMode = false
        //return darkMode ? .default : .lightContent
        return .lightContent
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        //cell.detailText.text = videos[indexPath.item].title
        //cell.titleLabel.text = videos[indexPath.item].title
        //cell.thumbnailImageView.image = UIImage(named: videos[indexPath.item].thumbnailImageName!)
        
        let vd = videos[indexPath.item]
        vd.index = indexPath.item
        cell.video = vd
        
        //cell.subtitleTextView.layoutIfNeeded()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func readJsonFile() -> JSON{
        if let path = Bundle.main.path(forResource: "home", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                //print("jsonData:\(jsonObj)")
                return jsonObj
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                return JSON()
            }
        } else {
            print("Invalid filename/path.")
            return JSON()
        }
    }
}
