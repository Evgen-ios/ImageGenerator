//
//  CoreDataManager.swift
//  Image Generator
//
//  Created by Evgeniy Goncharov on 21.05.2023.
//

import UIKit
import CoreData

public class CoreDataManager {
    
    // MARK: - Properties
    static let shared = CoreDataManager()
    
    private var persistentContainer: NSPersistentContainer = {
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName("UIImageTransformer"))
        
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    // MARK: - Methods
    func appendItem(model: ImageModel) {
        let imageData = ImageCoreData(context: persistentContainer.viewContext)
        imageData.reguest = model.reguest
        imageData.image = model.image
        imageData.time = model.time
        
        try? self.persistentContainer.viewContext.save()
    }
    
    func removeItem(model: ImageCoreData) {
        persistentContainer.viewContext.delete(model)
        try? self.persistentContainer.viewContext.save()
    }
    
    func getItems() -> [ImageCoreData] {
        let fetchRequest: NSFetchRequest<ImageCoreData> = ImageCoreData.fetchRequest()
        guard let items = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            print("ERROR: Can't get items")
            return []
        }
        return items.sorted(by: { $0.time > $1.time } )
    }
    
    func checkItem(by key: String) -> Bool {
        getItems().contains(where: {  $0.reguest == key })
    }
    
}
