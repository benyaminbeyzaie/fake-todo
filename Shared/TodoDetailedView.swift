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
                        
                    }
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
