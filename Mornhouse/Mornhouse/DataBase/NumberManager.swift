//
//  NumberManager.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit
import CoreData

class NumberManager: DBManager {
    
    func fetchData() -> [MHNumber] {
        let request: NSFetchRequest<MHNumber> = MHNumber.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results?.sorted(by: { $0.date ?? Date() > $1.date ?? Date() }) ?? []
    }
    
    @discardableResult
    func insert(number: Int, fact: String) -> MHNumber? {
        guard let object = NSEntityDescription.insertNewObject(forEntityName: "MHNumber", into: backgroundContext) as? MHNumber else { return nil }
        defer { save() }
        object.number = Int64(number)
        object.fact = fact
        object.date = Date()
        return object
    }
    
}
