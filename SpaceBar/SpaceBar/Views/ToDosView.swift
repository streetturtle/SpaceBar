//
//  ToDosView.swift
//  SpaceBar
//
//  Created by Pavel Makhov on 2022-10-06.
//

import SwiftUI
import SkeletonUI

struct ToDosView: View {
    private let spaceClient = SpaceClient()
    var model: Model
    @State private var asd: String = ""

    
    var body: some View {
        VStack {
            SkeletonList(with: model.todos, quantity: 3) { loading, todo in
                TodoView(todo: todo, loading: loading, model: model)
            }
            
            TextField("Add a task", text: $asd)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 8)
                                .padding(.leading, 22)
                                .background(Color("textFieldBackgroundTransparent"))
                                .cornerRadius(8)
                                .textFieldStyle(PlainTextFieldStyle())
                                .overlay(
                                    Image(systemName: "plus.circle.fill")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                ).onSubmit {
                                    spaceClient.createTodo(text: asd) { 
                                        model.getTodos()
                                    }
                                    asd = ""
                                }
            
        }.padding(8)
    }
}

struct ToDosView_Previews: PreviewProvider {
    static var previews: some View {
        ToDosView(model: Model())
    }
}
