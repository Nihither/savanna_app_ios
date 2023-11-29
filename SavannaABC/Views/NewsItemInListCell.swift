//
//  NewsItemInListCell.swift
//  SavannaABC
//
//  Created by Андрей Семенов on 13.11.2023.
//

import UIKit

class NewsItemInListCell: UITableViewCell {
    
    @IBOutlet weak var newsItemTitle: UILabel!
    @IBOutlet weak var newsItemImage: UIImageView!
    @IBOutlet weak var newsItemText: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setImage(image: UIImage) {
        let hRatio = image.size.height / image.size.width
        let newImageHeight = hRatio * UIScreen.main.bounds.width
        heightConstraint.constant = newImageHeight
        newsItemImage.image = image
        newsItemImage.layoutIfNeeded()
    }
    
}
