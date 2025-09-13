//
//  DBManager.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit
import CoreData

class DBManager {
    
    let persistentContainer: NSPersistentContainer!
    
    lazy var backgroundContext: NSManagedObjectContext = { persistentContainer.newBackgroundContext() }()
    
    init(container: NSPersistentContainer) {
        persistentContainer = container
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    func save() {
        guard backgroundContext.hasChanges else { return }
        do {
            try backgroundContext.save()
            Logger.log("Object saved")
        } catch {
            Logger.log("Save error \(error)")
        }
    }
    
}
