import Foundation
import SwiftUI

struct Todo: Identifiable {
    var id: UUID
    var title: String
    var dueDate: Date
    var theme: Theme
    var isDone: Bool
    var createDate: Date
    var color: Color
    
    init(id: UUID = UUID(), title: String, dueDate: Date, theme: Theme, isDone: Bool, color: Color , createDate: Date) {
        self.id = id;
        self.dueDate = dueDate;
        self.title = title;
        self.theme = theme;
        self.isDone = isDone;
        self.color = color
        self.createDate = createDate
    }
}


extension Todo {
    struct Data {
        var title: String = ""
        var dueDate: Date = Date()
        var theme: Theme = .seafoam
        var isDone: Bool = false
        var color: Color = Color.white
        var createDate: Date = Date.now
    }
    
    var data: Data {
        Data(title: title, dueDate: dueDate, theme: theme, isDone: isDone , color: color , createDate: createDate)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        theme = data.theme
        dueDate = data.dueDate
        isDone = data.isDone
        color = data.color
        createDate = data.createDate
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        theme = data.theme
        dueDate = data.dueDate
        isDone = data.isDone
        color = data.color
        createDate = data.createDate
    }
}

extension Todo {
    static let sample: [Todo] = [
        Todo.init(title: "b", dueDate: Date.now, theme: Theme.yellow, isDone: false , color: Color.yellow , createDate: Date.now),
        Todo.init(title: "a", dueDate: Date.distantPast, theme: Theme.yellow, isDone: false , color: Color.red , createDate: Date.now),
        Todo.init(title: "c", dueDate: Date.now, theme: Theme.yellow, isDone: false, color: Color.white , createDate: Date.now),
    ]
}

extension Todo {
    static let empty: [Todo] = []
}
