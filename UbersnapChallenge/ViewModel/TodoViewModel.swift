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
        
        fetch()
        fetchCurrentWeek()
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
        let today = Date()
        let calender = Calendar.current
        
        let week = calender.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        print(self.currentDay)
        (1...7).forEach { day in
            if let weekday = calender.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current

        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}
