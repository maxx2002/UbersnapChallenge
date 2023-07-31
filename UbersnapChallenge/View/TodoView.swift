//
//  TodoView.swift
//  UbersnapChallenge
//
//  Created by Maximus Aurelius Wiranata on 31/07/23.
//

import SwiftUI

struct TodoView: View {
    
    @StateObject var vm: TodoViewModel = TodoViewModel()
    
    @State var showingAddView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                ForEach(vm.tasks) { task in
                    TaskCardView(task: task)
                }
                .onDelete(perform: vm.deleteTask)
                
                Spacer()
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddTaskView(vm: vm)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
//            .preferredColorScheme(.dark)
    }
}
