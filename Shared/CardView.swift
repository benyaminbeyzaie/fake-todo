//
//  CardView.swift
//  TodoApp (iOS)
//
//  Created by Benyamin on 6/9/22.
//

import SwiftUI

struct CardView: View {
    // Create Date Formatter
    let dateFormatter = DateFormatter();

    let todo: Todo
    var body: some View {
        VStack(alignment: .leading ) {
               Text(todo.title)
                .font(.headline).frame(maxWidth: .infinity, alignment: .leading)
               Spacer()
               HStack {
                   Image(systemName: "calendar")
                                   .frame(width: 20, height: 20, alignment: .leading)
                 Text(todo.dueDate, style: .date)
                   
               }
        }.padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var todo = Todo.sample[0]
    static var previews: some View {
        CardView(todo: todo).background(todo.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
