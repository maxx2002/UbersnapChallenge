//
//  AddTaskView.swift
//  UbersnapChallenge
//
//  Created by Maximus Aurelius Wiranata on 31/07/23.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var desc = ""
    @State private var date = Date()
    
    @ObservedObject var vm: TodoViewModel
    
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
                DatePicker("Due Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
            } header: {
                Text("Task Due Date")
            }
            .onAppear {
                date = vm.currentDay
            }
            
            Section {
                Button {
                    vm.addTask(title: title, desc: desc, status: "Not completed", date: date)
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
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(vm: TodoViewModel())
    }
}
