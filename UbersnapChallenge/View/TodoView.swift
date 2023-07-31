//
//  TodoView.swift
//  UbersnapChallenge
//
//  Created by Maximus Aurelius Wiranata on 31/07/23.
//

import SwiftUI

struct TodoView: View {
    
    @StateObject var vm: TodoViewModel = TodoViewModel()
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                List {
                    ForEach(vm.tasks) { task in
                        TaskCardView(task: task)
                    }
                    .onDelete(perform: vm.deleteTask)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Todo List")
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
