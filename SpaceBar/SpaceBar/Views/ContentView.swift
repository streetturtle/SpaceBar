//
//  ContentView.swift
//  SpaceBar
//
//  Created by Pavel Makhov on 2022-10-06.
//

import SwiftUI
import Defaults

struct ContentView: View {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var selectedStatusId = ""
    @State var type = "assigned"
    @StateObject var model = Model()
    
    @Default(.orgName) var orgName
    @Default(.projectId) var projectId
    var body: some View {
        
        NavigationView {
            List {
                VStack(alignment: .center) {
                    Image("space-logo")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                    
                    Text(orgName)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    
                    Picker("", selection: $projectId, content: {
                        ForEach(model.projects, id: \.id) { i in
                            Text("\(i.name)").tag(i)
                        }
                    }).labelsHidden()
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 140)
                        .onAppear{
//                            self.model.projects.removeAll()
                            self.model.getProjects()
                        }
                        .onChange(of: projectId) { id in
                            model.selected = ""
                            model.refresh()
                        }
                    
                }
                Section ("Features") {
                    NavigationLink(destination: IssuesView(model: model, selectedStatusId: $selectedStatusId, selectedType: $type),
                                   tag: "1",
                                   selection: $model.selected) {
                        NavLink(text: "Issues", count: "\(model.issues.count)", systemName: "staroflife.fill")
                    }
                    
                    NavigationLink(destination: CodeReviewsView(model: model),
                                   tag: "2",
                                   selection: $model.selected) {
                        NavLink(text: "Code Reviews", count: "\(model.codeReviews.count)", systemName: "highlighter")
                    }
                    
                    NavigationLink(destination: ToDosView(model: model),
                                   tag: "3",
                                   selection: $model.selected) {
                        NavLink(text: "ToDos", count: "\(model.todos.count)", systemName: "checkmark.square") }
                }
                
                Section("App"){
                    NavigationLink{ SettingsView()} label: { Label("Settings", systemImage: "gearshape") }
                    NavigationLink{ AboutView()} label: { Label("About", systemImage: "info") }
                    Label("Quit", systemImage: "power")
                        .onTapGesture {
                            appDelegate.quit()
                        }
                }
            }
            .listStyle(.sidebar)
            .frame(width: 180)
            
            Text("No selection")
            //                DropdownSelector(
            //                    selectedOption: DropdownOption(key: "2", value: "Monday"),
            //                    placeholder: "Day of the week",
            //                    options: [
            //                        DropdownOption(key: "1", value: "Sunday"),
            //                        DropdownOption(key: "2", value: "Monday"),
            //                        DropdownOption(key: "3", value: "Tuesday"),
            //                        DropdownOption(key: "4", value: "Wednesday"),
            //                        DropdownOption(key: "5", value: "Thursday"),
            //                        DropdownOption(key: "6", value: "Friday")],
            //                    onOptionSelected: { option in
            //                        print(option)
            //                    })
            //                    .padding(.horizontal)
            //            }
            //
        }.onAppear {
            model.refresh()
        }
    }
}

struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        self.text = text
    }
}
