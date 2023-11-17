//
//  NewsItemViewController.swift
//  SavannaABC
//
//  Created by Андрей Семенов on 12.11.2023.
//

import UIKit

class NewsItemViewController: UIViewController {
    
    @IBOutlet weak var newsItemTitle: UILabel!
    @IBOutlet weak var newsItemImage: UIImageView!
    @IBOutlet weak var newsItemText: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var newsTitle: String = ""
    var newsText: String = ""
    var newsImageName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
       
        newsItemTitle.text = newsTitle
        setImage(image: UIImage(named: newsImageName)!)
        newsItemText.text = newsText

        // Do any additional setup after loading the view.
    }
    
    func setImage(image: UIImage) {
        let hRatio = image.size.height / image.size.width
        let newImageHeight = hRatio * UIScreen.main.bounds.width
        heightConstraint.constant = newImageHeight
        newsItemImage.image = image
        newsItemImage.layoutIfNeeded()
    }

}
