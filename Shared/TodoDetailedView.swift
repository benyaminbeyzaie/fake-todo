//
//  TodoDetailedView.swift
//  TodoApp (iOS)
//
//  Created by Benyamin on 6/9/22.
//

import SwiftUI

struct TodoDetailedView: View {
    @Binding var todo: Todo
    
    @State private var data = Todo.Data()
    @State private var isPresentingEditView = false

    
    var body: some View {
        List {
            Section(header: Text("Todo details")) {
                Label(todo.title, systemImage: "timer")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                HStack {
                    Image(systemName: "calendar")
                                    .frame(width: 20, height: 20, alignment: .leading)
                    HStack {
                        Text(todo.dueDate, style: .date)
                        Spacer()
                        Text(todo.dueDate, style: .time)
                    }
                }
            }
          
            Button(action: { todo.update(from: Todo.Data(title: todo.title, dueDate: todo.dueDate, theme: todo.theme, isDone: true, color: todo.color, createDate: todo.createDate)) }) {
                    Text("Done")
            }.padding()
            .foregroundColor(.green)
            
        }.navigationTitle(todo.title).toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = todo.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                TodoDetailedEditView(data: $data)
                    .navigationTitle(todo.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                todo.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct TodoDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TodoDetailedView(todo: .constant(Todo.sample[0]))
        }
    }
}
