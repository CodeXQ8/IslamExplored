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
    
    func updateCell(nameLbl : String,excerpt: String, imageView: UIImage){
        self.nameLbl.text = nameLbl
        self.excerpt.text = excerpt
        self.bookImage.image = imageView
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
