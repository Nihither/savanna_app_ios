//
//  File.swift
//  SavannaABC
//
//  Created by Андрей Семенов on 12.11.2023.
//

import Foundation

struct K {
    struct Identifiers {
        static let goToTabViewFromLogin: String = "goToTabViewFromLogin"
        static let goToNewsItem: String = "goToNewsItem"
        static let newsItemCell: String = "newsItemInListCell"
        static let newsItemInListCellNibName = "NewsItemInListCell"
    }
    struct Backend {
        static let baseUrl: String = "http://192.168.0.47:8000"
    }
    struct Plist {
        static let username: String = "username"
        static let password: String = "password"
        static let uuid: String = "uuid"
    }
}
