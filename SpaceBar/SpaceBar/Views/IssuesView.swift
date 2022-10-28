//
//  IssuesView.swift
//  SpaceBar
//
//  Created by Pavel Makhov on 2022-10-06.
//

import SwiftUI
import SkeletonUI


struct IssuesView: View {
    @State var model: Model
    @Binding var selectedStatusId: String
    @Binding var selectedType: String
    @State private var hoveringOver = false

    var body: some View {
        VStack(spacing: 0) {
            
            List(model.issues) { issue in
                IssueView(issue: issue, model: model)
            }
            
            HStack(alignment: .bottom) {
                HStack {
                    Button(action: {
                        if selectedType == "assigned"
                        {
                            model.getIssues(statusId: selectedStatusId)
                            selectedType = ""
                        } else {
                            model.getIssues(statusId: selectedStatusId, type: "assigned")
                            selectedType = "assigned"
                        }

                    })
                    {
                    Text("Assigned")
                        .padding([.leading, .trailing], 4)
                        .padding([.top, .bottom], 2)
                        .foregroundColor(.secondary)
                        .background(RoundedRectangle(cornerRadius: 50, style: .continuous).fill(selectedType == "assigned" ? Color.secondary.opacity(0.5) : Color.red.opacity(0)))
                        .font(.subheadline)
                        .padding([.top, .bottom], 8)
                    }
                    .buttonStyle(PlainButtonStyle())

                    Button(action: {
                        if selectedType == "created"
                        {
                            model.getIssues(statusId: selectedStatusId)
                            selectedType = ""
                        } else {
                            model.getIssues(statusId: selectedStatusId, type: "created")
                            selectedType = "created"
                        }

                    })
                    {
                    Text("Created")
                        .padding([.leading, .trailing], 4)
                        .padding([.top, .bottom], 2)
                        .foregroundColor(.secondary)
                        .background(RoundedRectangle(cornerRadius: 50, style: .continuous).fill(selectedType == "created" ? Color.secondary.opacity(0.5) : Color.red.opacity(0)))
                        .font(.subheadline)
                        .padding([.top, .bottom], 8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    ForEach(Constants.issueStatuses, id: \.id) { status in
                        Button(action: {
                            if selectedStatusId == status.id {
                                model.getIssues(type: selectedType)
                                selectedStatusId = ""
                            } else {
                                model.getIssues(statusId: status.id, type: selectedType)
                                selectedStatusId = status.id
                            }
                        })
                        {
                            Text(status.name)
                                .padding([.leading, .trailing], 4)
                                .padding([.top, .bottom], 2)
                                .background(RoundedRectangle(cornerRadius: 50, style: .continuous).fill(selectedStatusId == status.id ? Color(hex: status.color) : Color.red.opacity(0)))
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding([.top, .bottom], 8)
                }
            }
            .padding([.leading, .trailing], 16)
            
        }
    }
}

//struct IssuesView_Previews: PreviewProvider {
//    static var model = Model()
//    static let issues = [
//        Issue(id: "1a2b", title: "Title", status: FieldWithId(id: "123"), number: 1)
//    ]
//    
//    static var previews: some View {
//        IssuesView(model: model, selectedStatus: .constant("asd"))
//    }
//}

