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
//        var document = PDFDocument(url: Bundle.main.url(forResource: "\(1)", withExtension: "pdf")!)!
    let PDFBooks = ["The Key to Understanding Islam","Women in Islam","Human Rights in Islam","Jesus Man Messenger Messiah","Why Islam? - Proofs of Modern Science","How He Treated Them","The True Muslim", "Sharia law in Islam, Christianity and Judaism"]

    let PDFExcerpt = [
            "This book makes the readers aware about Islam, the Prophet Muhammad, the Islamic rites, Islam’s attitude towards the Prophet Jesus and his mother (peace be upon him).",
            "This book discusses the special place women have in the religion of Islam and seeks to address some of the many misconceptions and false propaganda published by those who are ignorant of this religion or harbor a malicious intent to purposely misrepresent this religion.",
            "Human Rights in Islam: A book by Sheikh Jamal Zarabozo – may allah bless him – in which he tackled the issue of Islam and human rights in the shadow of Islam.",
            "This book explains where and how the Qur’an challenges the traditional Church narrative.In doing so, it presents the reader with a compelling and clear understanding of Jesus and his true message. The book also demonstrates why the Qur’an is the ‘missing link’, that all important ‘bridge’ connecting Judaism and Christianity, uniting all of the Abrahamic faiths.",
            "Why Islam? – Proofs of Modern Science",
            "Today individuals find themselves in desperate need of guidance. Over the ages, Allah sent different Prophets to guide humanity and provide answers to the questions confronting man. The most important features of their mission was to explain the Divine laws and exemplify Divine wisdom, and thus, serve as role-models to their nations. This book shows how the Prophet Muhammad (peace be upon him) introduced Islam in all of his cases: father, husband, neighbor, friend, seller, buyer, judge, … etc. Thus he dealt with all kinds of people while showing the Islamic teachings in all cases.",
            "The true muslim",
            "Sharia law in Islam, Christianity and Judaism"
        ]
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.tableHeaderView?.isHidden = true;
        
        let bookCell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookViewCell
        bookCell.selectionStyle = .none
       
        if indexPath.row == 0 {
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
        } else {
//            let documentFileURL = Bundle.main.url(forResource: "\(indexPath.row)", withExtension: "pdf")!
//             document = PDFDocument(url: documentFileURL)!
            let name = PDFBooks[indexPath.row - 1]
            let excerpt = PDFExcerpt[indexPath.row - 1]
            let image = UIImage(named: "\(indexPath.row + 21).jpg")
            bookCell.updateCell(nameLbl: name, excerpt: excerpt, imageView: image!, screenWidth: screenWidth, screenModel: UIDevice().type)

        }
        
        return bookCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PDFBooks.count + 1
    
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            performSegue(withIdentifier: "showBook", sender: self)
        }else {
            performSegue(withIdentifier: "showPDF", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let indexPath = tableView.indexPathForSelectedRow  {

            
            if segue.identifier == "showBook"{

            guard let epub = Epub(rawValue: indexPath.row) else {
                return
            }
            self.open(epub: epub)
            } else {
                let PDFViewVC = segue.destination as? PDFViewVC
                PDFViewVC?.indexPath = indexPath.row
            }
    }
    
    }
}
