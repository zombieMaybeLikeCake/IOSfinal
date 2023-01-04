//
//  newsView.swift
//  f00957120
//
//  Created by User20 on 2022/12/27.
//

import SwiftUI
import Kingfisher
struct newsView: View {
  var title:String
  var banner: String
  var category:String
  var url :String
  var external_link :String?
  
  var body: some View {
    VStack(alignment: .center){
      Text(title)
        .fontWeight(.bold)
      KFImage(URL(string:banner))
        .resizable()
        .scaledToFill().frame(width: 100, height: 200)
      Link("前往網站觀看", destination: URL(string:url)!).multilineTextAlignment(.center)
      if let external_link = external_link{

        if let url = URL(string: external_link) {
            Link("延伸連結", destination: url).multilineTextAlignment(.center).padding()

        }

      }
      if let category = category {
        Text("種類："+category).padding()
      }
    }.frame(width: 350, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
  }
}

struct newsView_Previews: PreviewProvider {
    static var previews: some View {
      newsView(title:"Masters 2023 is Coming to Japan!",banner: "https://images.contentstack.io/v3/assets/bltb6530b271fddd0b1/blt4e5b64160805770f/639917fb2a7bba15c026283f/122422_VCT23_Masters_Location_Announcement_Banner.jpg",category: "esports",url:"https://playvalorant.com/en-us/news/esports/masters-2023-is-coming-to-japan/",external_link: "https://valorantesports.com/news/masters-2023-is-coming-to-japan/")
    }
}
