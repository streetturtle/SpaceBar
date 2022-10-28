//
//  AboutView.swift
//  SpaceBar
//
//  Created by Pavel Makhov on 2022-10-08.
//

import SwiftUI

struct AboutView: View {

    let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

    var body: some View {
        Text("SpaceBar - macOS application which simiplifies interaction with JetBrains Space")
        Text("version: \(currentVersion)")
        Text("Made by [Pavel Makhov](https://github.com/streetturtle)")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
