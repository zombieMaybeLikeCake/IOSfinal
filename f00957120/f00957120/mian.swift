//
//  mian.swift
//  final00957120
//
//  Created by User20 on 2022/12/26.
//

import SwiftUI

struct mian: View {
    @StateObject private var fetcher = ItunesDataFetcher()
    var body: some View {
      TabView{
                  searchView().tabItem {Label("搜尋對手" ,systemImage:"hammer")}
              newsUIView().tabItem {Label( "遊戲新聞" ,systemImage:"hammer")}
              }
    }
}

struct mian_Previews: PreviewProvider {
    static var previews: some View {
        mian().environmentObject(ItunesDataFetcher())
    }
}
