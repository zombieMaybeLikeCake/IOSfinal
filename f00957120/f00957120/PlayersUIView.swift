//
//  PlayersUIView.swift
//  f00957120
//
//  Created by User20 on 2022/12/28.
//

import SwiftUI
import Kingfisher
struct PlayersUIView: View {
  var item: Players
    var body: some View {
      HStack() {
        
        Text(item.data.name)
          .font(.title)
          .multilineTextAlignment(.leading)
        Spacer()
        KFImage(URL(string:item.data.card.wide))
          .resizable()
          .scaledToFit().frame(width: 200, height: 100)
        Spacer()
      }.frame(width: 300, height: 100)
    }
}

struct PlayersUIView_Previews: PreviewProvider {
    static var previews: some View {
      PlayersUIView(item:example)
    }
}
