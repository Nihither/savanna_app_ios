//
//  NewsList.swift
//  SavannaABC
//
//  Created by Андрей Семенов on 24.11.2023.
//

import Foundation


struct NewsList: Codable {
    let news: Array<News>
}

struct News: Codable {
    let id: Int
    let title: String
    let text: String
    let image_url: String
    let createdDate: Date
}
