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
    @State private var sortMode = "-";
    @State private var showingSheet = false;
    
    
    func sortByAlphabet() {
        todos = todos.sorted(by: { $0.title < $1.title })
    }
    
    func sortByDueDate() {
        todos = todos.sorted(by: { $0.dueDate <= $1.dueDate })
    }
    
    func sortByCreatedDate() {
        todos = todos.sorted(by: { $0.createDate <= $1.createDate })
    }
    
    func sort() {
        if (sortMode == "Alphabet") {
            sortByAlphabet();
        } else if (sortMode == "Due Date") {
            sortByDueDate();
        } else if (sortMode == "Build Date") {
            sortByCreatedDate();
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $showAll) {
                    Text("Show all")
                }.padding()
                DatePicker(selection: $dateFilter, displayedComponents: .date) {
                    Text("Select a date")
                }.padding().disabled(showAll)
                HStack{
                    Text("Sort Method: ")
                    Spacer()
                    Button(sortMode) {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet, onDismiss: {
                        sort();
                    }) {
                        SheetView(sortMode: self.$sortMode)
                    }
                    
                }.padding()
                List {
                    ForEach($todos, id: \.title) { $todo in
                        let sameDay = Calendar.current.isDate(todo.dueDate, equalTo: dateFilter, toGranularity: .day)
                        
                        if ((showAll || sameDay) && !todo.isDone) {
                            NavigationLink(destination: TodoDetailedView(todo: $todo)) {
                                CardView(todo: todo)
                            }.swipeActions(edge: .leading) {
                                Button (action: { todo.update(from: Todo.Data(title: todo.title, dueDate: todo.dueDate, theme: todo.theme, isDone: true))
                                }) {
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
                    
                }.onAppear{
                    sort();
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
                                            sort();
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

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var sortMode: String
    var body: some View {
        Button("Alphabet") {
            sortMode = "Alphabet"
            dismiss()
        }
        Button("Due Date") {
            sortMode = "Due Date"
            dismiss()
        }
        Button("Build Date") {
            sortMode = "Build Date"
            dismiss()
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todos: .constant(Todo.sample))
    }
}
