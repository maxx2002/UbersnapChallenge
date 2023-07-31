//
//  TodoView.swift
//  UbersnapChallenge
//
//  Created by Maximus Aurelius Wiranata on 31/07/23.
//

import SwiftUI

struct TodoView: View {
    
    @StateObject var vm: TodoViewModel = TodoViewModel()
    
    @State var showAddView: Bool = false
    @State var showEditView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                ForEach(vm.tasks) { task in
                    TaskCardView(task: task, showEditView: $showEditView, vm: vm)
//                        .onTapGesture {
//                            showEditView.toggle()
//                        }
//                        .sheet(isPresented: $showEditView) {
//                            EditTaskView(vm: vm, task: task)
//                        }
                }
                
                Spacer()
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddTaskView(vm: vm)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
