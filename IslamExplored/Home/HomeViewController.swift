//
//  HomeViewController.swift
//  MediumClone
//
//  Created by OLUNUGA Mayowa on 18/09/2018.
//  Copyright © 2018 OLUNUGA Mayowa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , onStoryItemClickedProtocol{
    
    var postVC : PostVC?
    
    @IBOutlet weak var tableView: UITableView!
    
    var postsArticles = Array<Post>()
    var postsFqa = Array<Post>()
    var posts = Array<Post>()
    
    let articles = 35
    let fqa = 36
    let foundation = 158
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
       return refreshControl
    }()
    
    let screenWidth = UIScreen.main.bounds.width
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllPosts()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        print(screenWidth)
        getDataSavedPost()

        tableView.register(UINib(nibName: "WideStoryViewCell", bundle: nil), forCellReuseIdentifier: "wideCell")
        tableView.register(UINib(nibName: "SwipableTableViewCell", bundle: nil), forCellReuseIdentifier: "swipeCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 240.0
        tableView.separatorColor = UIColor(white: 0.5, alpha: 0.3)
        tableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }
    

    
    
    
    func fetchAllPosts(){
        fetchFoundation()
        fetchArticles()
        fetchFQA()
    }
    
    
    func fetchFoundation() {
        let siteURL = "https://islamexplored.org/wp-json/wp/v2"
        
        let postRequest = PostRequest(url:siteURL, page:1, perPage:100, categories: foundation)
        postRequest.fetchLastPosts(completionHandler: { posts, error in
            if let newposts = posts {
                DispatchQueue.main.async {
                    self.postsArticles = newposts
                }
            }
        })
        
    }
    
    func fetchArticles() {
        let siteURL = "https://islamexplored.org/wp-json/wp/v2"
        
        let postRequest = PostRequest(url:siteURL, page:1, perPage:100, categories: articles)
        postRequest.fetchLastPosts(completionHandler: { posts, error in
            if let newposts = posts {
                for post in newposts {
                    DispatchQueue.main.async {
                        self.postsArticles.append(post)
                        self.tableView.reloadData()
                    }
                }
            }
        })
        
    }
    
    func fetchFQA() {
        let siteURL = "https://islamexplored.org/wp-json/wp/v2"
        
        let postRequest = PostRequest(url:siteURL, page:1, perPage:100, categories: fqa)
        postRequest.fetchLastPosts(completionHandler: { posts, error in
            if let newpostsF = posts {
                DispatchQueue.main.async {
                    self.postsFqa = newpostsF
                    self.tableView.reloadData()
                }
            }
        })
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
             getDataSavedPost()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getDataSavedPost()
        
    }
    
    func containPostId(postId: Int) -> Bool {
        let exists = savedForLaterArray.contains(where: { (post) -> Bool in
            if post.id == postId {
                return true
            } else {
                return false
            }
        })
        return exists
    }
    
    func getDataSavedPost(){
        let data = defaults?.value(forKey: "savedPost") as? [Int]
        let posts = postsArticles + postsFqa
            if data != nil && posts != nil {
                for postId in data! {
                    for post in posts {
                        if postId == post.id{
                            let exists = containPostId(postId: postId)
                            if exists != true {
                                savedForLaterArray.insert(post, at: 0)
                            }
                        }
                    }
                }
            } else {
                
            }
        }
    
    
   
    
    @objc func handleRefresh(_ refreshControl : UIRefreshControl) {
        refreshControl.endRefreshing();
    }
    
    
    func buttonPressed(action: Action) {
            share()
    }
    
    
    
    func share() {
        let activityVC = UIActivityViewController(activityItems:[ "hello ","\n\(link)"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view
        present(activityVC,animated: true, completion: nil)
    }
    
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsFqa.count;
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.tableHeaderView?.isHidden = true;

        let wideCell = tableView.dequeueReusableCell(withIdentifier: "wideCell", for: indexPath) as! WideStoryViewCell
        wideCell.selectionStyle = .none
        wideCell.setDelegate(delegate: self)
        
        
            let post = self.postsFqa[indexPath.row]
   //     DispatchQueue.main.async {
            let title = String(htmlEncodedString:post.title)
            let contentLbl = String(htmlEncodedString:post.excerpt)
            wideCell.updateCell(title: title, contentLbl: contentLbl, screenWidth: self.screenWidth, screenModel: UIDevice().type )
        //}
//        let post = postsFqa[indexPath.row]
//        let title = String(htmlEncodedString:post.title)
//        let contentLbl = String(htmlEncodedString:post.excerpt)
//        wideCell.updateCell(title: title, contentLbl: contentLbl, screenWidth: screenWidth, screenModel: UIDevice().type )
//        print(screenWidth)
        
        let swipeCell = tableView.dequeueReusableCell(withIdentifier: "swipeCell", for: indexPath) as! SwipableTableViewCell
        swipeCell.selectionStyle = .none
        swipeCell.hideTitle()
        swipeCell.copmpactCellData = postsArticles
        swipeCell.HomeViewController = self
        
        if indexPath.row == 0 {
            return swipeCell
        }
        
       
        return wideCell
    }
    
    func showPostDetail(post:Post){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let postVC = storyboard.instantiateViewController(withIdentifier: "PostVC") as? PostVC
        postVC?.post = post
        navigationController?.pushViewController(postVC!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
                let selectedPost = postsFqa[indexPath.row]
                let postVC = segue.destination as? PostVC
                postVC?.post = selectedPost
                postVC?.index = indexPath.row
        }
        
        let SearchVC = segue.destination as? SearchVC
        SearchVC?.posts =  postsArticles + postsFqa
        

    }
    
    
}
