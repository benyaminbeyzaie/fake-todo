//
//  TodoAppApp.swift
//  Shared
//
//  Created by Benyamin on 6/9/22.
//

import SwiftUI

@main
struct TodoApp: App {
    @State private var todos = Todo.sample

    var body: some Scene {
        WindowGroup {
            TababrView(todos: $todos)
        }
    }
}
