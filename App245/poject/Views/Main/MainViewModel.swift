//
//  MainViewModel.swift
//  App245
//
//  Created by IGOR on 13/11/2023.
//

import SwiftUI
import CoreData

final class MainViewModel: ObservableObject {
    
    @Published var isAdd: Bool = false
    
    @Published var selectedObject: MainModel? = nil
    @Published var isDetail: Bool = false

    @Published var types: [String] = ["All", "Project", "Construction", "Finish"]
    @Published var current_type = "All"
    
    @Published var address: String = ""
    @Published var cost: String = ""
    
    @Published var objects: [MainModel] = []
    
    func addObject(completion: @escaping () -> (Void)) {
        
        CoreDataStack.shared.modelName = "MainModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let trans = NSEntityDescription.insertNewObject(forEntityName: "MainModel", into: context) as! MainModel
        
        trans.address = address
        trans.cost = Int16(cost) ?? 0
        
        CoreDataStack.shared.saveContext()
        
        completion()
    }
    
    func fetchObjects() {
        
        CoreDataStack.shared.modelName = "MainModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MainModel>(entityName: "MainModel")

        do {
            
            let branch = try context.fetch(fetchRequest)
            
            self.objects = branch
            
        } catch let error as NSError {
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.objects = []
        }
    }
}
