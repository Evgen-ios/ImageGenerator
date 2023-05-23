//
//  Entity+CoreDataProperties.swift
//  Image Generator
//
//  Created by Evgeniy Goncharov on 21.05.2023.
//
//

import UIKit
import CoreData

extension ImageCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageCoreData> {
        return NSFetchRequest<ImageCoreData>(entityName: "ImageCoreData")
    }

    @NSManaged public var image: UIImage?
    @NSManaged public var reguest: String?
    @NSManaged public var time: Date
}
