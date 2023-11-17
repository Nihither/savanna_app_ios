//
//  NewsItem.swift
//  SavannaABC
//
//  Created by Андрей Семенов on 12.11.2023.
//

import Foundation

struct NewsItem {
    let title: String
    let text: String
    let imageName: String
    
    init(title: String, text: String, imageName: String) {
        self.title = title
        self.text = text
        self.imageName = imageName
    }
}
