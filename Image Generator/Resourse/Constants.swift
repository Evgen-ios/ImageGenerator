//
//  Constants.swift
//  Image Generator
//
//  Created by Evgeniy Goncharov on 20.05.2023.
//

import Foundation

struct Constants {
    static let scheme = "https"
    static let host = "dummyimage.com"
    static let placeholder = "Введите запрос..."
}

public enum ImageSize: String, CaseIterable {
    case lite = "100x100"
    case medium = "500x500"
    case hard = "1000x1000"
}
