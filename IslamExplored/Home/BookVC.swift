//
//  BookVC.swift
//  IslamExplored
//
//  Created by Nayef Alotaibi on 12/30/18.
//  Copyright © 2018 Islam_Explored. All rights reserved.
//

import UIKit
import FolioReaderKit

class BookVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
        let folioReader = FolioReader()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(BookVC.handleRefresh3(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    let screenWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "BookViewCell", bundle: nil), forCellReuseIdentifier: "BookCell")
        tableView.addSubview(refreshControl)
    }
    
    private func readerConfiguration(forEpub epub: Epub) -> FolioReaderConfig {
        let config = FolioReaderConfig(withIdentifier: epub.readerIdentifier)
        config.shouldHideNavigationOnTap = epub.shouldHideNavigationOnTap
        config.scrollDirection = epub.scrollDirection
        
        // See more at FolioReaderConfig.swift
        //        config.canChangeScrollDirection = false
        //        config.enableTTS = false
        //        config.displayTitle = true
        //        config.allowSharing = false
                  config.tintColor = UIColor.gray
        //        config.toolBarTintColor = UIColor.redColor()
        //        config.toolBarBackgroundColor = UIColor.purpleColor()
        //        config.menuTextColor = UIColor.brownColor()
        //        config.menuBackgroundColor = UIColor.lightGrayColor()
        //        config.hidePageIndicator = true
        //        config.realmConfiguration = Realm.Configuration(fileURL: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("highlights.realm"))
        
        // Custom sharing quote background
        config.quoteCustomBackgrounds = []
        if let image = UIImage(named: "demo-bg") {
            let customImageQuote = QuoteImage(withImage: image, alpha: 0.6, backgroundColor: UIColor.black)
            config.quoteCustomBackgrounds.append(customImageQuote)
        }
        
        let textColor = UIColor(red:0.86, green:0.73, blue:0.70, alpha:1.0)
        let customColor = UIColor(red:0.30, green:0.26, blue:0.20, alpha:1.0)
        let customQuote = QuoteImage(withColor: customColor, alpha: 1.0, textColor: textColor)
        config.quoteCustomBackgrounds.append(customQuote)
        
        return config
    }
    
    fileprivate func open(epub: Epub) {
        guard let bookPath = epub.bookPath else {
            return
        }
        
        let readerConfiguration = self.readerConfiguration(forEpub: epub)
        folioReader.presentReader(parentViewController: self, withEpubPath: bookPath, andConfig: readerConfiguration, shouldRemoveEpub: false)
    }
    
    private func setCover(_ button: UIButton?, index: Int) {
        guard
            let epub = Epub(rawValue: index),
            let bookPath = epub.bookPath else {
                return
        }
        
        do {
            let image = try FolioReader.getCoverImage(bookPath)
            
            button?.setBackgroundImage(image, for: .normal)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    @objc func handleRefresh3(_ refreshControl : UIRefreshControl) {
        refreshControl.endRefreshing();
    }
    
}






// MARK: - IBAction

//extension BookVC {
//    
//    @IBAction func didOpen(_ sender: AnyObject) {
//        guard let epub = Epub(rawValue: sender.tag) else {
//            return
//        }
//        
//        self.open(epub: epub)
//    }
//}

extension BookVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.tableHeaderView?.isHidden = true;
        
        let bookCell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookViewCell
        bookCell.selectionStyle = .none
        if let epub = Epub(rawValue: indexPath.row) {
        let bookPath = epub.bookPath
        let name = epub.name
        let excerpt = epub.excerpt
            do {
                let image = try FolioReader.getCoverImage(bookPath!)
                bookCell.updateCell(nameLbl: name, excerpt: excerpt, imageView: image, screenWidth: screenWidth, screenModel: UIDevice().type)
              
            } catch {
                print(error.localizedDescription)
            }
            

        }
        
        return bookCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showBook", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let indexPath = tableView.indexPathForSelectedRow {

            guard let epub = Epub(rawValue: indexPath.row) else {
                return
            }
            self.open(epub: epub)
            
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let containerVC = segue.destination as? ExampleFolioReaderContainer
//                containerVC?.epub =
//        }

    }
    
    }
}
