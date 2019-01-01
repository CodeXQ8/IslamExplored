//
//  BookmarkViewController.swift
//  IslamExplored
//
//  Created by Nayef Alotaibi on 12/29/18.
//  Copyright © 2018 Islam_Explored. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class BookmarkViewController: UIViewController {
    

    let cellId : String = "wideCell"
    
    @IBOutlet weak var tableView: UITableView!
    let screenWidth = UIScreen.main.bounds.width

    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(BookmarkViewController.handleRefresh1(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        tableView.register(UINib(nibName: "WideStoryViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        tableView.addSubview(refreshControl)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print(savedForLaterArray)
        tableView.reloadData()
    }
    

    
    @objc func handleRefresh1(_ refreshControl : UIRefreshControl) {
        refreshControl.endRefreshing();
    }
    
}




extension BookmarkViewController : UITableViewDelegate, UITableViewDataSource, EmptyDataSetSource, EmptyDataSetDelegate {
    
        func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
                let str = "Bookmarks"
                return NSAttributedString(string: str)
            }
    
        
        func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {

            var  str = "Your bookmarked posts will appear here"

            return NSAttributedString(string: str)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedForLaterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! WideStoryViewCell
        cell.selectionStyle = .none
        let post = savedForLaterArray[indexPath.row]
        let title = String(htmlEncodedString:post.title)
        let contentLbl = String(htmlEncodedString:post.excerpt)
        
        cell.updateCell(title: title, contentLbl: contentLbl, screenWidth: screenWidth, screenModel: UIDevice().type )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail1", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            let selectedPost = savedForLaterArray[indexPath.row]
            let postVC = segue.destination as? PostVC
            postVC?.post = selectedPost
            postVC?.index = indexPath.row
        }
        
        
    }
    
    
}

