//
//  TababrView.swift
//  TodoApp (iOS)
//
//  Created by Benyamin on 6/11/22.
//

import SwiftUI

struct TababrView: View {
    @Binding var todos: [Todo]
    
    var body: some View {
        TabView {
            TodoListView(todos: $todos)
                .tabItem {
                    Label("Todos", systemImage: "bolt.circle")
                }
            DoneListView(todos: $todos)
                .tabItem {
                    Label("Done tasks", systemImage: "clock.badge.checkmark")
                    
                }
        }
    }
}

struct TababrView_Previews: PreviewProvider {
    static var previews: some View {
        TababrView(todos: .constant(Todo.sample))
    }
}
