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
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 10) {
                        ForEach(vm.currentWeek, id: \.self) { day in
                            VStack (spacing: 10) {
                                Text(vm.extractDate(date: day, format: "dd"))
                                    .font(.system(size: 15))
                                    .bold()
                                
                                Text(vm.extractDate(date: day, format: "EEE"))
                                    .font(.system(size: 14))
                                
                                Circle()
                                    .fill(.white)
                                    .frame(width: 8, height: 8)
                                    .opacity(vm.isToday(date: day) ? 1 : 0)
                            }
                            .foregroundStyle(vm.isToday(date: day) ? .primary : .secondary)
                            .foregroundColor(vm.isToday(date: day) ? .white : .black)
                            .frame(width: 45, height: 90)
                            .background(
                                ZStack {
                                    if vm.isToday(date: day) {
                                        Capsule()
                                            .fill(.black)
                                    }
                                }
                            )
                            .contentShape(Capsule())
                            .onTapGesture {
                                vm.currentDay = day
                            }
                        }
                    }
                    .padding()
                }
                
                ForEach(vm.tasks) { task in
                    TaskCardView(task: task, showEditView: $showEditView, vm: vm)
                }
                
                Spacer()
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(vm.extractDate(date: vm.currentDay, format: "E, d MMM y"))
                }
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
            .sheet(isPresented: $showEditView) {
                EditTaskView(vm: vm)
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
