//
//  TasksViewModel.swift
//  App245
//
//  Created by IGOR on 14/11/2023.
//

import SwiftUI
import CoreData
import Alamofire

final class TasksViewModel: ObservableObject {
    
    @Published var taskDescription: String = ""
    @AppStorage("workers") var workers: [String] = []
    @Published var selectedWorker: String = ""
    @Published var isAddTask: Bool = false
    @Published var currentWorker = ""
    
    @Published var tasks: [TaskModel] = []
    
    func addTasks(completion: @escaping () -> (Void)) {
        
        CoreDataStack.shared.modelName = "TaskModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let trans = NSEntityDescription.insertNewObject(forEntityName: "TaskModel", into: context) as! TaskModel
        
        trans.taskWorker = selectedWorker
        trans.taskDescription = taskDescription
        
        CoreDataStack.shared.saveContext()
        
        completion()
    }
    
    func fetchTasks() {
        
        CoreDataStack.shared.modelName = "TaskModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TaskModel>(entityName: "TaskModel")

        do {
            
            let branch = try context.fetch(fetchRequest)
            
            self.tasks = branch
            
        } catch let error as NSError {
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.tasks = []
        }
    }
}

