//
//  ImageLoader.swift
//  SavannaABC
//
//  Created by Андрей Семенов on 29.11.2023.
//

import Foundation
import UIKit

class ImageLoader {
    private let imageUrl: URL
    
    init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }
    
    var image: UIImage? {
        get async throws {
            let (data, _) = try await URLSession.shared.data(from: imageUrl)
            return UIImage(data: data)
        }
    }
}
