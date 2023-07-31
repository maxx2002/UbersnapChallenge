//
//  TaskCardView.swift
//  UbersnapChallenge
//
//  Created by Maximus Aurelius Wiranata on 31/07/23.
//

import SwiftUI

struct TaskCardView: View {
    var task: Task
    @Binding var showEditView: Bool
    @ObservedObject var vm: TodoViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Text(task.title ?? "")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                Button {
                    showEditView.toggle()
                    print(task)
                } label: {
                    Text("Edit")
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $showEditView) {
                    EditTaskView(vm: vm, task: task)
                }
            }
            
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: task.status == "Completed" ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .font(.title3)
                    .foregroundColor(task.status == "Completed" ? .green : .red)
                
                Text(task.status ?? "")
                    .fontWeight(.semibold)
            }
            
            Text(task.desc ?? "")
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.primary, lineWidth: 2)
        )
        .padding([.horizontal, .bottom])
    }
}
