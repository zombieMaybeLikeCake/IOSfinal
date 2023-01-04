//
//  final00957120App.swift
//  final00957120
//
//  Created by User20 on 2022/12/26.
//

import SwiftUI

@main
struct final00957120App: App {
  @StateObject private var fetcher = ItunesDataFetcher()
     var body: some Scene {
         WindowGroup {
          searchView()
                 .environmentObject(fetcher)
         }
     }
}
