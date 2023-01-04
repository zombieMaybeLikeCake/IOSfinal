//
//  f00957120App.swift
//  f00957120
//
//  Created by User20 on 2022/12/27.
//

import SwiftUI
import Kingfisher
@main
struct f00957120App: App {
  @StateObject private var fetcher = ItunesDataFetcher()
    var body: some Scene {
        WindowGroup {
            mian().environmentObject(fetcher)
        }
    }
}
