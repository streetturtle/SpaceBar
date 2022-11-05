//
//  IssueStatusView.swift
//  SpaceBar
//
//  Created by Pavel Makhov on 2022-11-03.
//

import SwiftUI

struct IssueStatusView: View {
    
    @State private var isHovering = false
    
    @State var issue: Issue
    
    var body: some View {
        Menu {
            ForEach(Constants.issueStatuses) {status in
                Button(status.name, action:{
                    SpaceClient().updateIssueStatus(issueId: issue.id, newStatusId: status.id) {
                        issue.status.id = status.id
                    }
                })
            }
        }
        label: {
            Text(Constants.issueStatuses.filter{i in i.id == issue.status.id}.first?.name ?? "")
                .font(.subheadline)
        }
        .scaledToFit()
        .menuStyle(BorderlessButtonMenuStyle())
        .padding([.leading, .trailing], 4)
        .padding([.top, .bottom], 2)
        .background(
            RoundedRectangle(cornerRadius: 50, style: .continuous).fill(Color(hex: (Constants.issueStatuses.filter{i in i.id == issue.status.id}.first?.color ?? "333333")))
        )
        .foregroundColor(.secondary)
        
    }
}

//struct IssueStatusView_Previews: PreviewProvider {
//    static var previews: some View {
//        IssueStatusView(issue: Issue(id: "123", title: "Issue Title", status: <#T##FieldWithId#>, number: <#T##Int#>))
//    }
//}
