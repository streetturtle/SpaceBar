//
//  NavLink.swift
//  SpaceBar
//
//  Created by Pavel Makhov on 2022-10-20.
//

import SwiftUI

struct NavLink: View {
    var text: String
    var count: String
    var systemName: String
    
    var body: some View {
        Label {
            Text(text)
            Spacer()
            Text(count)
                .foregroundColor(Color.secondary)
            
        } icon: {
            Image(systemName: systemName)
        }
    }
}
