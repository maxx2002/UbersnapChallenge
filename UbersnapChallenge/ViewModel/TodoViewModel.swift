//
//  TodoViewModel.swift
//  UbersnapChallenge
//
//  Created by Maximus Aurelius Wiranata on 31/07/23.
//

import Foundation
import CoreData

class TodoViewModel: ObservableObject {
    let container = NSPersistentContainer(name: "TodoData")
    @Published var tasks: [Task] = []
    @Published var selectedTask: Task = Task()
    
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
        
        fetchCoreDataRequest()
        
        fetchCurrentWeek()
    }
    
    func fetchCoreDataRequest() {
        let request = NSFetchRequest<Task>(entityName: "Task")
        let sort = NSSortDescriptor(key: "status", ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            tasks = try container.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
    }
    
    func save() {
        do {
            try container.viewContext.save()
            fetchCoreDataRequest()
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
        task.date = date
        
        save()
    }
    
    func editTask(task: Task, title: String, desc: String, status: String, date: Date) {
        task.title = title
        task.desc = desc
        task.status = status
        task.date = date
        
        save()
    }
    
    func deleteTask(task: Task) {
        container.viewContext.delete(task)
        
        save()
    }
    
    func fetchCurrentWeek() {
        self.currentWeek = []
        
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: self.currentDay)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (0...6).forEach { day in
            if var weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                weekday = calendar.date(byAdding: .hour, value: 7, to: weekday) ?? Date()
                currentWeek.append(weekday)
            }
        }
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current

        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}
