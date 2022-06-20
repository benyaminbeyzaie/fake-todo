//
//  TodoListView.swift
//  TodoApp (iOS)
//
//  Created by Benyamin on 6/9/22.
//

import SwiftUI

struct TodoListView: View {
    @Binding var todos: [Todo]
    @State private var isPresentingNewTodoView = false
    @State private var newTodoData = Todo.Data()
    @State private var dateFilter = Date()
    @State private var showAll = false;
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $showAll) {
                    Text("Show all")
                }.padding()
                DatePicker(selection: $dateFilter, displayedComponents: .date) {
                    Text("Select a date")
                }.padding().disabled(showAll)
                List {
                    ForEach($todos, id: \.title) { $todo in
                        let sameDay = Calendar.current.isDate(todo.dueDate, equalTo: dateFilter, toGranularity: .day)

                        if ((showAll || sameDay) && !todo.isDone) {
                            NavigationLink(destination: TodoDetailedView(todo: $todo)) {
                                CardView(todo: todo)
                            }.swipeActions(edge: .leading) {
                                Button (action: { todo.update(from: Todo.Data(title: todo.title, dueDate: todo.dueDate, theme: todo.theme, isDone: true)) }) {
                                    Label("Done", systemImage: "clock.badge.checkmark")
                                }
                                .tint(.green)
                            }
                            .swipeActions(edge: .trailing) {
                                Button (action: { todos.removeAll(where: { $0.id == todo.id })}) {
                                    Label("Delete", systemImage: "delete.left.fill")
                                }
                                .tint(.red)
                            }
                            
                        }
                    }
                    
                }.navigationTitle("Todos")
                    .toolbar {
                        Button(action: {
                            isPresentingNewTodoView = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }.sheet(isPresented: $isPresentingNewTodoView) {
                        NavigationView {
                            TodoDetailedEditView(data: $newTodoData)
                                .navigationTitle("New Todo")
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Dismiss") {
                                            isPresentingNewTodoView = false
                                        }
                                    }
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button("Add") {
                                            let newTodo = Todo(data: newTodoData)
                                            todos.append(newTodo)
                                            isPresentingNewTodoView = false
                                            newTodoData = Todo.Data()
                                        }
                                    }
                                }
                        }
                    }
                
            }
            
            
            
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todos: .constant(Todo.sample))
        
    }
}
