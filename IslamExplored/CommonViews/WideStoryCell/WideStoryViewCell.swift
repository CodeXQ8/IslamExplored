//
//  WideStoryViewCell.swift
//  MediumClone
//
//  Created by OLUNUGA Mayowa on 18/09/2018.
//  Copyright © 2018 OLUNUGA Mayowa. All rights reserved.
//

import UIKit

protocol onStoryItemClickedProtocol {
    //should contain the id of the data that was pressed
    func buttonPressed(action : Action)
}

enum Action {
    case menu
    case bookMark
}

class WideStoryViewCell: UITableViewCell {
    var delegate : onStoryItemClickedProtocol? = nil
    @IBOutlet weak var actionMenuWidthConstraint: NSLayoutConstraint!
    
  //  @IBOutlet weak var bookmarkButtonTrailingContraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    @IBOutlet weak var buttonBookmark: UIButton!
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!

    @IBOutlet weak var ViewCell: UIView!
    
    
    
    func updateCell(title : String, contentLbl: String, screenWidth: CGFloat, screenModel: Model ){
        self.titleLbl.text = title
        self.contentLbl.text = contentLbl
        

        switch screenModel {
        case .iPhoneSE,.iPhone5,.iPhone5S,.iPhone6,.iPhone7,.iPhone6S,.iPhone6plus,.iPhone6Splus,.iPhone7plus,.iPhone8,.iPhone8plus,.iPhoneX,.iPhoneXS,.iPhoneXSMax, .iPhoneXR:
            
            self.titleLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            self.titleLbl.widthAnchor.constraint(equalToConstant: screenWidth - 35 ).isActive = true
            
            self.contentLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            self.contentLbl.widthAnchor.constraint(equalToConstant: screenWidth - 35 ).isActive = true
            
        default:
            self.titleLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            self.titleLbl.widthAnchor.constraint(equalToConstant: screenWidth / 1.5 ).isActive = true
            self.contentLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            self.contentLbl.widthAnchor.constraint(equalToConstant: screenWidth / 1.5 ).isActive = true
        }
    }
    
    func setDelegate(delegate : onStoryItemClickedProtocol){
        self.delegate = delegate
    }
    
    @IBAction func menuPressed(_ sender: UIButton) {
        if let deleg = delegate {
            deleg.buttonPressed(action: .menu)
        }
    }
    
//    @IBAction func bookMarkPressed(_ sender: UIButton) {
//        if let deleg = delegate {
//            deleg.buttonPressed(action: .bookMark)
//        }
//    }
}


