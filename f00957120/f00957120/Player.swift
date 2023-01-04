//
//  Player.swift
//  final00957120
//
//  Created by User20 on 2022/12/26.
//
//import Kingfisher
import SwiftUI
import Kingfisher
struct Player: View {
    @State var gamer = example
    @State private var time = ""
    var item: Players
    var photo :String
    var body: some View {
        VStack() {
          Spacer()

            Text(item.data.name).padding()
            Spacer()
          VStack(){
            KFImage(URL(string:gamer.data.card.large))
              .resizable().scaledToFill().frame(width: 70, height: 70)

              Spacer()
            /*KFImage( URL(string:item.data.card.large) )
              .resizable()
              .scaledToFill().frame(width: 70, height: 100)*/
              Spacer()
            Text("等級："+String(item.data.account_level))
            Text("最後上線時間："+time).multilineTextAlignment(.center).padding()
            Text("ID:"+item.data.puuid).padding()
          }
          Spacer()
        }.frame(width: 300, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).onAppear(){
            if let urlString = "https://api.henrikdev.xyz/valorant/v1/account/\(item.data.name)/\(item.data.tag)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) { data, response , error in

                    if let data = data {

                        let decoder = JSONDecoder()
                        do {

                            let newslist = try decoder.decode(Players.self, from: data)
                            gamer = newslist

                        } catch {

                            print(error)
                        }
                    } else if let error = error {

                        print(error)
                    }
                }.resume()
            }
          time=item.data.last_update
          if(time == "Now"){
            time="上線中"
          }
          else{
            time=convertDateTime(timeValue:item.data.last_update_raw)
          }

        }

    }
  

}

struct Player_Previews: PreviewProvider {
    static var previews: some View {
        Player(item: example,photo:example.data.card.large)
    }
}
