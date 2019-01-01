//
//  PostVC.swift
//  Islam
//
//  Created by Nayef Alotaibi on 9/2/18.
//  Copyright © 2018 Nayef Alotaibi. All rights reserved.
//

import UIKit
import WebKit



let defaults = UserDefaults(suiteName: "Islam.Explored")
var savedForLaterArray = Array<Post>()

class PostVC: UIViewController, WKNavigationDelegate {
    
   
    
    
    @IBOutlet weak var WKView: WKWebView!
    @IBOutlet weak var postContent: UITextView!
    
    
    
    var html : String = " "
    var postTitle  : String = " "
    var postId : Int = 0
    var link : String = " "
    
    var containerHeight = CGFloat()
    var contentString = String()
    var index : Int = 0
    var isSaved = Bool ()
    
    var isDark : Bool = false
    
    var savedPost = [Int]()
    var saved : Bool = false
    
    var posts : [Post]?
    
    var post: Post? {
        didSet {
            html = (post?.content)!
            postTitle = (post?.title)!
            postId = (post?.id)!
            link = (post?.link)!
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        updateSaveImage()
        webKitSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateSaveImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getData()
    }

    func updateSaveImage(){
        if let index = savedPost.index(of: postId) {
            savedBtn.image = UIImage(named: "iconfinder_bookmark_1608585")
        } else {
            savedBtn.image = UIImage(named: "iconfinder_bookmark-o_1608584")
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        getData()
    }
    
    func webKitSetUp(){
        WKView.navigationDelegate = self
        WKView.isUserInteractionEnabled = true
        WKView.isMultipleTouchEnabled = true;
        WKView.scrollView.showsHorizontalScrollIndicator = false
        WKView.scrollView.showsVerticalScrollIndicator = false
        WKView.backgroundColor = UIColor .clear;
        WKView.clipsToBounds = true
        
        
        
        switch UIDevice().type {
        case .iPhoneSE,.iPhone5,.iPhone5S,.iPhone6,.iPhone7,.iPhone6S,.iPhone6plus,.iPhone6Splus,.iPhone7plus,.iPhone8,.iPhone8plus,.iPhoneX,.iPhoneXS,.iPhoneXSMax, .iPhoneXR:   WKView.loadHTML(html: html, title: postTitle)
        default:
               WKView.loadHTMLIpad(html: html, title: postTitle)
        }
        

    }
    
    func storeData(savedPost : [Int]){
        defaults?.set(savedPost, forKey: "savedPost")
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
    
    func getData(){
        let data = defaults?.value(forKey: "savedPost") as? [Int]
        
        if data != nil{
            self.savedPost = data as! [Int]
            if posts != nil  {
                for postId in data! {
                    for post in posts! {
                        if postId == post.id{
                            let exists = containPostId(postId: postId)
                            if exists != true {
                                savedForLaterArray.insert(post, at: 0)
                            }
                        }
                    }
                }
            }
        }
        else {
            
        }
    }
    
    @IBOutlet weak var savedBtn: UIBarButtonItem!
    @IBAction func SaveBtnWasPressed(_ sender: Any) {
        
        
        if let index = savedPost.index(of: postId) {
            savedPost.remove(at: index)
            savedForLaterArray.remove(at: index)
            print(savedPost)
            print(savedPost)
            storeData(savedPost: savedPost)
            savedBtn.image = UIImage(named: "iconfinder_bookmark-o_1608584")
        } else {
            savedPost.insert(postId, at: 0)
            print(savedPost)
            storeData(savedPost: savedPost)
            savedBtn.image = UIImage(named: "iconfinder_bookmark_1608585")
        }
        
    }
    
    /// Get the Link from wordpress ///
    @IBAction func shareBtnWasPressed(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems:[ postTitle,"\n\(link)"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC,animated: true, completion: nil)
    }
    
    
    
    
}
extension WKWebView {
    
    func loadHTML(html: String, title: String) {
        let htmlString = """
        <link rel="stylesheet" type="text/css" href="style.css">
        <h1> \(String(htmlEncodedString:title)) </h1>
        <meta name="viewport" content="initial-scale=1.0" />
        <span>\(html)</span>
        """
        self.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
    }
    
    func loadHTMLIpad(html: String, title: String) {
        let htmlString = """
        <link rel="stylesheet" type="text/css" href="styleIpad.css">
        <h1> \(String(htmlEncodedString:title)) </h1>
        <meta name="viewport" content="initial-scale=1.0" />
        <span>\(html)</span>
        """
        self.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
    }
}


public enum Model : String {
    case simulator     = "simulator/sandbox",
    //iPod
    iPod1              = "iPod 1",
    iPod2              = "iPod 2",
    iPod3              = "iPod 3",
    iPod4              = "iPod 4",
    iPod5              = "iPod 5",
    //iPad
    iPad2              = "iPad 2",
    iPad3              = "iPad 3",
    iPad4              = "iPad 4",
    iPadAir            = "iPad Air ",
    iPadAir2           = "iPad Air 2",
    iPad5              = "iPad 5", //aka iPad 2017
    iPad6              = "iPad 6", //aka iPad 2018
    //iPad mini
    iPadMini           = "iPad Mini",
    iPadMini2          = "iPad Mini 2",
    iPadMini3          = "iPad Mini 3",
    iPadMini4          = "iPad Mini 4",
    //iPad pro
    iPadPro9_7         = "iPad Pro 9.7\"",
    iPadPro10_5        = "iPad Pro 10.5\"",
    iPadPro12_9        = "iPad Pro 12.9\"",
    iPadPro2_12_9      = "iPad Pro 2 12.9\"",
    //iPhone
    iPhone4            = "iPhone 4",
    iPhone4S           = "iPhone 4S",
    iPhone5            = "iPhone 5",
    iPhone5S           = "iPhone 5S",
    iPhone5C           = "iPhone 5C",
    iPhone6            = "iPhone 6",
    iPhone6plus        = "iPhone 6 Plus",
    iPhone6S           = "iPhone 6S",
    iPhone6Splus       = "iPhone 6S Plus",
    iPhoneSE           = "iPhone SE",
    iPhone7            = "iPhone 7",
    iPhone7plus        = "iPhone 7 Plus",
    iPhone8            = "iPhone 8",
    iPhone8plus        = "iPhone 8 Plus",
    iPhoneX            = "iPhone X",
    iPhoneXS           = "iPhone XS",
    iPhoneXSMax        = "iPhone XS Max",
    iPhoneXR           = "iPhone XR",
    //Apple TV
    AppleTV            = "Apple TV",
    AppleTV_4K         = "Apple TV 4K",
    unrecognized       = "?unrecognized?"
}


// #-#-#-#-#-#-#-#-#-#-#-#-#-#-#
//MARK: UIDevice extensions
// #-#-#-#-#-#-#-#-#-#-#-#-#-#-#

public extension UIDevice {
    public var type: Model {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
                
            }
        }
        var modelMap : [ String : Model ] = [
            "i386"      : .simulator,
            "x86_64"    : .simulator,
            //iPod
            "iPod1,1"   : .iPod1,
            "iPod2,1"   : .iPod2,
            "iPod3,1"   : .iPod3,
            "iPod4,1"   : .iPod4,
            "iPod5,1"   : .iPod5,
            //iPad
            "iPad2,1"   : .iPad2,
            "iPad2,2"   : .iPad2,
            "iPad2,3"   : .iPad2,
            "iPad2,4"   : .iPad2,
            "iPad3,1"   : .iPad3,
            "iPad3,2"   : .iPad3,
            "iPad3,3"   : .iPad3,
            "iPad3,4"   : .iPad4,
            "iPad3,5"   : .iPad4,
            "iPad3,6"   : .iPad4,
            "iPad4,1"   : .iPadAir,
            "iPad4,2"   : .iPadAir,
            "iPad4,3"   : .iPadAir,
            "iPad5,3"   : .iPadAir2,
            "iPad5,4"   : .iPadAir2,
            "iPad6,11"  : .iPad5, //aka iPad 2017
            "iPad6,12"  : .iPad5,
            "iPad7,5"   : .iPad6, //aka iPad 2018
            "iPad7,6"   : .iPad6,
            //iPad mini
            "iPad2,5"   : .iPadMini,
            "iPad2,6"   : .iPadMini,
            "iPad2,7"   : .iPadMini,
            "iPad4,4"   : .iPadMini2,
            "iPad4,5"   : .iPadMini2,
            "iPad4,6"   : .iPadMini2,
            "iPad4,7"   : .iPadMini3,
            "iPad4,8"   : .iPadMini3,
            "iPad4,9"   : .iPadMini3,
            "iPad5,1"   : .iPadMini4,
            "iPad5,2"   : .iPadMini4,
            //iPad pro
            "iPad6,3"   : .iPadPro9_7,
            "iPad6,4"   : .iPadPro9_7,
            "iPad7,3"   : .iPadPro10_5,
            "iPad7,4"   : .iPadPro10_5,
            "iPad6,7"   : .iPadPro12_9,
            "iPad6,8"   : .iPadPro12_9,
            "iPad7,1"   : .iPadPro2_12_9,
            "iPad7,2"   : .iPadPro2_12_9,
            //iPhone
            "iPhone3,1" : .iPhone4,
            "iPhone3,2" : .iPhone4,
            "iPhone3,3" : .iPhone4,
            "iPhone4,1" : .iPhone4S,
            "iPhone5,1" : .iPhone5,
            "iPhone5,2" : .iPhone5,
            "iPhone5,3" : .iPhone5C,
            "iPhone5,4" : .iPhone5C,
            "iPhone6,1" : .iPhone5S,
            "iPhone6,2" : .iPhone5S,
            "iPhone7,1" : .iPhone6plus,
            "iPhone7,2" : .iPhone6,
            "iPhone8,1" : .iPhone6S,
            "iPhone8,2" : .iPhone6Splus,
            "iPhone8,4" : .iPhoneSE,
            "iPhone9,1" : .iPhone7,
            "iPhone9,3" : .iPhone7,
            "iPhone9,2" : .iPhone7plus,
            "iPhone9,4" : .iPhone7plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,4" : .iPhone8,
            "iPhone10,2" : .iPhone8plus,
            "iPhone10,5" : .iPhone8plus,
            "iPhone10,3" : .iPhoneX,
            "iPhone10,6" : .iPhoneX,
            "iPhone11,2" : .iPhoneXS,
            "iPhone11,4" : .iPhoneXSMax,
            "iPhone11,6" : .iPhoneXSMax,
            "iPhone11,8" : .iPhoneXR,
            //AppleTV
            "AppleTV5,3" : .AppleTV,
            "AppleTV6,2" : .AppleTV_4K
        ]
        
        if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
            if model == .simulator {
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    if let simModel = modelMap[String.init(validatingUTF8: simModelCode)!] {
                        return simModel
                    }
                }
            }
            return model
        }
        return Model.unrecognized
    }
}
