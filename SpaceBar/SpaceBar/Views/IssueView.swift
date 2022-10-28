//
//  IssueView.swift
//  SpaceBar
//
//  Created by Pavel Makhov on 2022-10-08.
//

import Foundation
import SwiftUI
import Defaults

struct IssueView: View {
    
    @Default(.orgName) var orgName
    @State private var isHovering = false
    
    
    @State var issue: Issue?
    @State var model: Model
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Link(destination: URL(string: "https://\(orgName).jetbrains.space/p/spcbr/issues/\(String(issue?.number ?? 1))")!) {
                    Text(issue?.title)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .font(.headline)
                    Text("#" + String(issue?.number ?? 1))
                        .foregroundColor(.secondary)
                }
            }
            Menu {
                ForEach(Constants.issueStatuses) {status in
                    Button(status.name, action:{
                        SpaceClient().updateIssueStatus(issueId: issue?.id ?? "", newStatusId: status.id) {
                            issue?.status.id = status.id
                        }
                    })
                }
            }
            label: {
                Text(Constants.issueStatuses.filter{i in i.id == issue?.status.id}.first?.name ?? "")
                    .font(.subheadline)
            }
            .scaledToFit()
            .menuStyle(BorderlessButtonMenuStyle())
            .padding([.leading, .trailing], 4)
            .padding([.top, .bottom], 2)
            .background(
                RoundedRectangle(cornerRadius: 50, style: .continuous).fill(Color(hex: (Constants.issueStatuses.filter{i in i.id == issue?.status.id}.first?.color ?? "333333")))
            )
            .foregroundColor(.secondary)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .onHover { over in
            isHovering = over
        }
        .padding(8)
        .background(
            isHovering
            ? RoundedRectangle(cornerRadius: 4, style: .continuous).fill(Color.secondary.opacity(0.1))
            : RoundedRectangle(cornerRadius: 4, style: .continuous).fill(Color.accentColor.opacity(0))
        )
        
    }
}