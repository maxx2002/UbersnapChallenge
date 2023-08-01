//
//  EditTaskView.swift
//  UbersnapChallenge
//
//  Created by Maximus Aurelius Wiranata on 31/07/23.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var desc = ""
    @State private var status = ""
    @State private var date = Date()
    
    @ObservedObject var vm: TodoViewModel
    
    let statusChoice = ["Not completed", "Completed"]
    
    var body: some View {
        Form {
            Section {
                TextField("Your Task", text: $title)
            } header: {
                Text("Task Title")
            }
            
            Section {
                TextEditor(text: $desc)
            } header: {
                Text("Task Description")
            }
            
            Section {
                Picker("Status", selection: $status) {
                   ForEach(statusChoice, id: \.self) {
                       Text($0)
                   }
               }
            } header: {
                Text("Task Status")
            }
            
            Section {
                DatePicker("Due Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
            } header: {
                Text("Task Due Date")
            }
            
            Section {
                Button {
                    vm.deleteTask(task: vm.selectedTask)
                    dismiss()
                } label: {
                    HStack {
                        Spacer()
                        Text("Delete Task")
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
            }
            .listRowBackground(Color.red)
            
            Section {
                Button {
                    vm.editTask(task: vm.selectedTask, title: title, desc: desc, status: status, date: date)
                    dismiss()
                } label: {
                    HStack {
                        Spacer()
                        Text("Save")
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
            }
            .listRowBackground(Color.blue)
        }
        .onAppear {
            title = vm.selectedTask.title ?? ""
            desc = vm.selectedTask.desc ?? ""
            status = vm.selectedTask.status ?? ""
            date = vm.selectedTask.date ?? Date()
            
            print("Edit task view \(vm.selectedTask)")
        }
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(vm: TodoViewModel())
    }
}
