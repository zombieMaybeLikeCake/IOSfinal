//
//  newsUIView.swift
//  f00957120
//
//  Created by User20 on 2022/12/27.
//

import SwiftUI

struct newsUIView: View {
  //newslist[item].data.count
  let roles = ["","game_updates", "dev", "esports", "announcments","all"]
  @State  var newslist : news?
  @State  var filiter = 1
  @State  var isRequestInProgress = true
  @State  var showAlert = false
  @State private var alertTitle = ""
  func getdata(sort: Int){
      if let urlString = "https://api.henrikdev.xyz/valorant/v1/website/en-us\("?filter="+roles[sort])".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
         let url = URL(string: urlString) {
          URLSession.shared.dataTask(with: url) { data, response , error in
            defer {
              DispatchQueue.main.async {
              self.isRequestInProgress = false
              }
            }
              if let data = data {
                
                  let decoder = JSONDecoder()
                  do {
                    
                      let newslist = try decoder.decode(news.self, from: data)
                    print(newslist)
                    self.newslist = newslist
                    self.showAlert = false
                  } catch {
                    self.showAlert = true
                      print(error)
                  }
              } else if let error = error {
                  self.showAlert = true
                  print(error)
              }
          }.resume()
      

    }
  
  }
  
    var body: some View {
      VStack{
        Text("news")
        VStack{
          Spacer()
          Picker(selection: $filiter, label: Text("選擇角色")) {
                      Text(roles[1]).tag(1)
                      Text(roles[2]).tag(2)
                      Text(roles[5]).tag(0)
                      Text(roles[3]).tag(3)
                      Text(roles[4]).tag(4)
          }.pickerStyle(SegmentedPickerStyle())
          Spacer()
          Button {
            isRequestInProgress = true
            getdata(sort:filiter)
          } label: {
                     Text("refrash")
                         .font(.system(size: 30))
                         .background(Color.blue)
                      .foregroundColor(.white)
                 }
        }.frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        if isRequestInProgress { //<-
            ProgressView()
        }
        Spacer()
        
        if let newslist = newslist{
          List(newslist.data, id : \.url){ n in
            
             
              //newsView(title: n.title, banner: n.bannerURL, category: n.category, url: n.url, external_link: nil).padding()
             


             newsView(title: n.title, banner: n.bannerURL, category: n.category, url: n.url, external_link: n.externalLink).padding()
          }.alert(isPresented: $showAlert, content: {
            let answer = "錯誤"
            return Alert(title: Text(answer))
   })
        }
      }.onAppear(){
        self.getdata(sort:filiter)
        if newslist?.status==400 {
          self.showAlert = true
        }
      }
      
      
    }
 
}



struct newsUIView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        newsUIView()
      }
    }
}

