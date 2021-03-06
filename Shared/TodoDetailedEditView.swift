//
//  TodoDetailedEditView.swift
//  TodoApp (iOS)
//
//  Created by Benyamin on 6/10/22.
//

import SwiftUI

struct TodoDetailedEditView: View {
    @Binding var data: Todo.Data
    
    var body: some View {
        Form {
            Section(header: Text("Todo")) {
                TextField("Title", text: $data.title)
                DatePicker(selection: $data.dueDate, in: Date()..., displayedComponents: [.date, .hourAndMinute]) {
                    Text("Date")
                }
                VStack {
                    ColorPicker("Set the background color", selection: $data.color , supportsOpacity: false)
                }
            }
        }
    }
}

struct TodoDetailedEditView_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetailedEditView(data: .constant(Todo.sample[0].data))
    }
}
