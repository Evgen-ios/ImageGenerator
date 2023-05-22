//
//  ImageModel.swift
//  Image Generator
//
//  Created by Evgeniy Goncharov on 20.05.2023.
//

import UIKit

class ImageModel {
    var image: UIImage
    var reguest: String
    var time: Date
    
    init(image: UIImage, request: String) {
        self.image = image
        self.reguest = request
        self.time = Date()
    }
}
