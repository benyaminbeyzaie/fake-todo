//
//  DoneListView.swift
//  TodoApp (iOS)
//
//  Created by Benyamin on 6/11/22.
//

import SwiftUI

struct DoneListView: View {
    @Binding var todos: [Todo]
    
    var body: some View {
        NavigationView {
            List {
                ForEach($todos, id: \.title) { $todo in
                    if (todo.isDone) {
                        NavigationLink(destination: TodoDetailedView(todo: $todo)) {
                            CardView(todo: todo)
                        }.swipeActions(edge: .trailing) {
                            Button (action: { todos.removeAll(where: { $0.id == todo.id })}) {
                                Label("Delete", systemImage: "delete.left.fill")
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            .navigationTitle("Done tasks")
        }
    }
}

struct DoneListView_Previews: PreviewProvider {
    static var previews: some View {
        DoneListView(todos: .constant(Todo.sample))
    }
}
