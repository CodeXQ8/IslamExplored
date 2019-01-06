//
//  QuranVC.swift
//  IslamExplored
//
//  Created by Nayef Alotaibi on 1/1/19.
//  Copyright © 2019 Islam_Explored. All rights reserved.
//

import UIKit
import FolioReaderKit

class QuranVC: UIViewController {

    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var excerptBook: UILabel!
    
    let folioReader = FolioReader()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let epub = Epub(rawValue: 0) {
            let bookPath = epub.bookPath
            let name = epub.name
            let excerpt = epub.excerpt
            do {
                let image = try FolioReader.getCoverImage(bookPath!)
                bookImage.layer.masksToBounds = true
//                bookImage.clipsToBounds = false
                bookImage.layer.shadowOffset = CGSize(width: -1, height: 1)
                bookImage.layer.shadowRadius = 1
                bookImage.layer.shadowOpacity = 0.5
                bookImage.layer.cornerRadius = 5
                
                bookName.text = name
                excerptBook.text = excerpt
                bookImage.image = image
                
            } catch {
                print(error.localizedDescription)
            }
            
    }
    }
    

    
    
    @IBAction func ReadBtn(_ sender: Any) {
        guard let epub = Epub(rawValue:  0) else {
            return
        }
            self.open(epub: epub)
            
        
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
    

}
