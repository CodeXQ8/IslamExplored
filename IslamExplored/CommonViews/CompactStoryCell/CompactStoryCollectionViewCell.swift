//
//  compactStoryCollectionViewCell.swift
//  MediumClone
//
//  Created by OLUNUGA Mayowa on 19/09/2018.
//  Copyright © 2018 OLUNUGA Mayowa. All rights reserved.
//

import UIKit
import MaterialComponents.MDCCard

class CompactStoryCollectionViewCell: MDCCardCollectionCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func updateCell(title : String, content: String, image: String){
        self.titleLbl.text = title
        self.contentLbl.text = content
        self.imageView.image = UIImage(named: image)
    }

}
