//
//  TableViewCell.swift
//  IslamExplored
//
//  Created by Nayef Alotaibi on 12/30/18.
//  Copyright © 2018 Islam_Explored. All rights reserved.
//

import UIKit

class BookViewCell: UITableViewCell {


    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var excerpt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(nameLbl : String,excerpt: String, imageView: UIImage,screenWidth: CGFloat,  screenModel: Model ){
        self.nameLbl.text = nameLbl
        self.excerpt.text = excerpt
        self.bookImage.image = imageView
        
        bookImage.layer.masksToBounds = true
        bookImage.layer.shadowOffset = CGSize(width: -1, height: 1)
        bookImage.layer.shadowRadius = 1
        bookImage.layer.shadowOpacity = 0.5
        bookImage.layer.cornerRadius = 5
        
        
        
//        switch screenModel {
//        case .iPhoneSE,.iPhone5,.iPhone5S,.iPhone6,.iPhone7,.iPhone6S,.iPhone6plus,.iPhone6Splus,.iPhone7plus,.iPhone8,.iPhone8plus,.iPhoneX,.iPhoneXS,.iPhoneXSMax, .iPhoneXR:
//            
//          //  self.nameLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//            self.nameLbl.widthAnchor.constraint(equalToConstant: screenWidth - 35 ).isActive = true
//            self.bookImage.rightAnchor.constraint(equalTo: contentView.leftAnchor, constant: 400) .isActive = true
//            
//           // self.contentLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//            self.excerpt.widthAnchor.constraint(equalToConstant: screenWidth - 35 ).isActive = true
//            
//        default:
//            self.nameLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//            self.nameLbl.widthAnchor.constraint(equalToConstant: screenWidth / 1.5 ).isActive = true
//            self.excerpt.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//            self.excerpt.widthAnchor.constraint(equalToConstant: screenWidth / 1.5 ).isActive = true
//        }
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
