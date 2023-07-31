//
//  TodoViewModel.swift
//  UbersnapChallenge
//
//  Created by Maximus Aurelius Wiranata on 31/07/23.
//

import Foundation
import CoreData
import SwiftUI

class TodoViewModel: ObservableObject {
    let container = NSPersistentContainer(name: "TodoData")
    @Published var tasks: [Task] = []
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
        
        fetch()
    }
    
    func fetch() {
        let request = NSFetchRequest<Task>(entityName: "Task")
        
        do {
            tasks = try container.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
    }
    
    func save() {
        do {
            try container.viewContext.save()
            fetch()
            print("Data Saved")
        } catch {
            print("Could not save the data")
        }
    }
    
    func addTask(title: String, desc: String, status: String, date: Date) {
        let task = Task(context: container.viewContext)
        task.id = UUID()
        task.title = title
        task.desc = desc
        task.status = status
        task.date = Date()
        
        save()
    }
    
    func editTask(task: Task, title: String, desc: String, status: String, date: Date) {
        task.title = title
        task.desc = desc
        task.status = status
        task.date = Date()
        
        save()
    }
    
    func deleteTask(offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(container.viewContext.delete)
            
            save()
        }
    }
}
