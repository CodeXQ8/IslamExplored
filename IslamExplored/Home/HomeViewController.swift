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
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllPosts()
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        
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
                                savedForLaterArray.append(post)
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
        switch action {
        case .bookMark:
            print("book mark was pressed")
            //tableView.reloadData()  Reload data in a single row
        case .menu:
            print("menu was pressed")
            showMenu()
        }
    }
    
    
    
    func showMenu() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Show fewer stories like this", style: .default, handler: { (action) in
            //do something
        }))
        alert.addAction(UIAlertAction(title: "Show fewer stories from Publisher", style: .default, handler: { (action) in
            //do something
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        let searchVC = SearchViewController()
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)
        view.window!.layer.add(transition, forKey: kCATransition)
    
        present(searchVC, animated: false, completion: nil)
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
        let post = postsFqa[indexPath.row]
        let title = String(htmlEncodedString:post.title)
        let contentLbl = String(htmlEncodedString:post.excerpt)
        wideCell.updateCell(title: title, contentLbl: contentLbl)

        
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
        

    }
    
    
}
