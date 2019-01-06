//
//  PDFViewVC.swift
//  IslamExplored
//
//  Created by Nayef Alotaibi on 1/2/19.
//  Copyright © 2019 Islam_Explored. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewVC: UIViewController {

    
    var indexPath = 0
    
    let PDFBooks = ["The Key to Understanding Islam","Women in Islam","Human Rights in Islam","Jesus Man Messenger Messiah","Why Islam? - Proofs of Modern Science","How He Treated Them","The True Muslim", "Sharia law in Islam, Christianity and Judaism"]
    
    @IBOutlet weak var PDFView: PDFView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
//        let remotePDFDocumentURLPath = "https://www.islamland.com/uploads/books/the_key_to_understanding_islam-eng.pdf"
//        let remotePDFDocumentURL = URL(string: remotePDFDocumentURLPath)!
//        let document = PDFDocument(url: remotePDFDocumentURL)!
//        
//        let readerController = PDFViewController.createNew(with: document)
//        navigationController?.pushViewController(readerController, animated: true)
        
        
        print("I am here at PDFVC")
        if let path = Bundle.main.path(forResource: "\(PDFBooks[indexPath - 1])", ofType: "pdf") {
//        let url = URL(fileURLWithPath: path)
            guard let url = URL(string:"https://www.islamland.com/uploads/books/the_key_to_understanding_islam-eng.pdf") else { return }
     //   let url = URL(fileURLWithPath: )
//        Downloader.load(url, to: <#URL#>)
            DispatchQueue.main.async {
                if let PDFDoc = PDFDocument(url:url) {
                    self.PDFView.autoScales = true
                    self.PDFView.displayMode = .singlePageContinuous
                    self.PDFView.displayDirection = .vertical
                    self.PDFView.document = PDFDoc
            }

            }
        }
    
    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(true)
//        self.tabBarController?.tabBar.isHidden = false
//
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        self.tabBarController?.tabBar.isHidden = false
//
//    }
    


}
