//
//  Todo.swift
//  TodoApp (iOS)
//
//  Created by Benyamin on 6/9/22.
//

import Foundation

struct Todo: Identifiable {
    var id: UUID
    var title: String
    var dueDate: Date
    var theme: Theme
    var isDone: Bool
    
    init(id: UUID = UUID(), title: String, dueDate: Date, theme: Theme, isDone: Bool) {
        self.id = id;
        self.dueDate = dueDate;
        self.title = title;
        self.theme = theme;
        self.isDone = isDone;
    }
}


extension Todo {
    struct Data {
        var title: String = ""
        var dueDate: Date = Date()
        var theme: Theme = .seafoam
        var isDone: Bool = false
    }
    
    var data: Data {
        Data(title: title, dueDate: dueDate, theme: theme, isDone: isDone)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        theme = data.theme
        dueDate = data.dueDate
        isDone = data.isDone
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        theme = data.theme
        dueDate = data.dueDate
        isDone = data.isDone
    }
}

extension Todo {
    static let sample: [Todo] = [
        Todo.init(title: "Todo one", dueDate: Date.now, theme: Theme.yellow, isDone: false),
        Todo.init(title: "Todo two", dueDate: Date.now, theme: Theme.yellow, isDone: false),
        Todo.init(title: "Todo three", dueDate: Date.now, theme: Theme.yellow, isDone: true),
    ]
}

extension Todo {
    static let empty: [Todo] = []
}
