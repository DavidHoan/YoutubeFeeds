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

    let menuTitleStr = ["Home", "Trending", "Subcriptions", "Account"]
    let cellId = "cellId"
    
    let trendingCellId = "trendingCellId"
    let subcriptionCellId = "subcriptionCellId"
    let profileCellId = "profileCellId"
    
    
    var videos:[Video] = {
        
//        var keynalChannel = Channel()
//        keynalChannel.name  = "KeynalIsTheBestChannel"
//        keynalChannel.profile_image_name = "youtuber_avatar"
//        
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        blankSpaceVideo.thumbnail_image_name = "taylor_swift"
//        //blankSpaceVideo.detail = "Taylor Swift VEVO - Blank Space - 1,604,208 views - 2 years ago."
//        blankSpaceVideo.channel = keynalChannel
//        blankSpaceVideo.number_of_views = 1424567098
//        
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood where human fight to live every day."
//        badBloodVideo.thumbnail_image_name = "taylor_swift1"
//        //badBloodVideo.detail = "Taylor Swift VEVO -  Bad Blood - 2,622,507 views - 3 years ago."
//        badBloodVideo.channel = keynalChannel
//        badBloodVideo.number_of_views = 29887375233
        
        return []
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        edgesForExtendedLayout = [] //UIRectEdgeNone
        //self.edgesForExtendedLayout = UIRectEdge.top
        //self.extendedLayoutIncludesOpaqueBars = true
        
    }
    
    var dragView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .blue
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHomeData()
        
        setupNavigationVC()
        
        setupCollectionView()
        
        setupMenuBar()
        
        setupNavBarButtons()
        
        
//        self.view.addSubview(dragView)
//
//        //addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
//
//
//        self.view.addConstraintsWithFormat(format: "H:|-100-[v0(100)]", views: dragView)
//        self.view.addConstraintsWithFormat(format: "V:|-100-[v0(100)]", views: dragView)
//
//        let tap = UILongPressGestureRecognizer(target: self, action: #selector(drag(_ :)))
//        tap.minimumPressDuration = 0.0
//
//        dragView.addGestureRecognizer(tap)
    }
    
//    var newCord: CGPoint = CGPoint(x: 0, y: 0)
//    var firstCord: CGPoint = CGPoint(x: 0, y: 0)
    
//    @objc func drag(_ sender: UILongPressGestureRecognizer ) {
//        if sender.view ==  nil {
//            return
//        }
//        if sender.state == UIGestureRecognizer.State.began {
//            
//        } else if sender.state == UIGestureRecognizer.State.ended {
//            
//        }
//        self.newCord = sender.location(in: self.view)
//        let x = newCord.x - (sender.view?.frame.width ?? 0 ) / 2
//        let y = newCord.y - (sender.view?.frame.height ?? 0 ) / 2
//        
//        dragView.frame = CGRect(x: x, y: y, width: dragView.frame.width, height: dragView.frame.height)
//        print("x: \(x) - y: \(y)")
//        view.bringSubviewToFront(dragView)
//    }
    
    func setupNavigationVC() {
        navigationController?.navigationBar.shadowImage = UIImage()
        //navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleLabel.text = "  Home"
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    
    
    func setupCollectionView() {
        
        let flowLayout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        
        collectionView.backgroundColor = .white
        
        //collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        
        collectionView.register(SubcriptionCell.self, forCellWithReuseIdentifier: subcriptionCellId)
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: profileCellId)
//        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
//        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView.isPagingEnabled = true
    }
    
    func scrollToMenuIndex(menuIndex:Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [] , animated: true)
        
        setTitleForItemIndex(menuIndex)
    }
    
    func setTitleForItemIndex(_ index: Int) {
        if let mtitle = navigationItem.titleView as? UILabel {
            mtitle.text = "  \(menuTitleStr[index])"
        }
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(targetContentOffset.pointee.x)
        
        let index = targetContentOffset.pointee.x / self.view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menubar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
        //let mindex:Int = Int(index)
        setTitleForItemIndex(Int(index))
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menubar.horizonBarLeftConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        } else if indexPath.item == 1 {
            return  collectionView.dequeueReusableCell(withReuseIdentifier: trendingCellId, for: indexPath)
        } else if indexPath.item == 2 {
            return  collectionView.dequeueReusableCell(withReuseIdentifier: subcriptionCellId, for: indexPath)
        } else if indexPath.item == 3 {
            return  collectionView.dequeueReusableCell(withReuseIdentifier: profileCellId, for: indexPath)
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let colors:[UIColor] = [.blue, .gray, .green, .purple]
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height:  self.view.frame.height)
    }
    
    func getHomeData() {
        APIService.shared.getHomeData(completion: { mvideos in
            self.videos = mvideos
            self.collectionView.reloadData()
        })
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
        
        navigationController?.hidesBarsOnSwipe = true
        
        /// redView - che khoảng trống giữa menu topbar - navigation bar
        /// pin to superview (not to safe layout)
        let redView = UIView()
        view.addSubview(redView)
        redView.backgroundColor = menubar.backgroundColor
        view.addConstraintsWithFormat(format:"H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format:"V:|[v0(50)]", views: redView)
        /// done
        
        view.addSubview(menubar)
        print("navigationItem.titleView :: \(String(describing: self.topbarHeight))")
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menubar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menubar)
        
        let guide = view.safeAreaLayoutGuide
        menubar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        menubar.homeController = self
    }
    
    
    /*
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
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
    
    */
    
    override func viewDidAppear(_ animated: Bool) {
        
        /// Auto select menu item
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        menubar.collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        //menubar.collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        //var darkMode = false
        //return darkMode ? .default : .lightContent
        return .lightContent
    }
    
}
