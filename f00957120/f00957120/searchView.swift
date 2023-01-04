//
//  searchView.swift
//  final00957120
//
//  Created by User20 on 2022/12/26.
//

import SwiftUI
import Kingfisher
struct searchView: View {

  @State private var name = "SweeTtt"
  @State private var tag = "cry"
  @State private var test = "121"
  @State var num :Int = 1
    @State var playerarry = [Player]()
    @State var player =     Player(item: example,photo:example.data.card.large)
  @EnvironmentObject var fetcher: ItunesDataFetcher
      var body: some View {
        NavigationView{
        VStack{
          HStack{
            Text("輸入要查詢的玩家名稱：")
            TextField("",text:$name).frame(width: 200, height: 50)
          }
          HStack{
            Text("輸入要查詢的玩家tag：")
            TextField("輸入要查詢的玩家tag#",text:$tag).frame(width: 200, height: 50)
          }
          Button {
            fetcher.isRequestInProgress = true
            fetcher.fetchData(name:name,tag:tag)
            player=Player(item:fetcher.items,photo:fetcher.items.data.card.large)
            playerarry.append(player)

          }
          label:{
                 Text("search")
                     .font(.system(size: 30))
          }
            if fetcher.isRequestInProgress {
                ProgressView()
            }
          List{
            ForEach(playerarry, id: \.item.data.name){ i in
              
              NavigationLink(
                destination:i)
                {
                HStack() {
                  
                  Text(i.item.data.name)
                    .font(.title)
                    .multilineTextAlignment(.leading)
                  Spacer()
                  KFImage(URL(string:i.item.data.card.wide))
                    .resizable()
                   .scaledToFit().frame(width: 300, height: 100)
                  Spacer()
                }.frame(width: 400, height: 100)
              }
            
                }
          }
            }
          }
      
      }
    }

struct searchView_Previews: PreviewProvider {
    static var previews: some View {
      searchView().environmentObject(ItunesDataFetcher())
    }
}
