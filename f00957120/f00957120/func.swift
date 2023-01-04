//
//  func.swift
//  final00957120
//
//  Created by User20 on 2022/12/26.
//
import Foundation
import UIKit
struct card : Codable{
    let small : String
    let large : String
    let wide : String
    let id :String
}

let cardexample = card(small:"https://media.valorant-api.com/playercards/9fb348bc-41a0-91ad-8a3e-818035c4e561/smallart.png" ,large:"https://media.valorant-api.com/playercards/9fb348bc-41a0-91ad-8a3e-818035c4e561/largeart.png",wide:"https://media.valorant-api.com/playercards/9fb348bc-41a0-91ad-8a3e-818035c4e561/wideart.png",id: "9fb348bc-41a0-91ad-8a3e-818035c4e561")
struct Playersdata: Codable {
    let puuid: String
    let region: String
    let account_level: Int
    let name :  String
    let tag :String
    let card :card
    let last_update :String
    let last_update_raw: Int
}
let dataexample = Playersdata(puuid: "aec6fd04-3eca-5fb6-a5fe-49626bf7ef1d", region: "ap", account_level: 22, name: "szmlrc", tag: "1758", card: cardexample, last_update: "Now", last_update_raw: 1672003773)
struct Players: Codable {
    let status: Int
    let data:   Playersdata
}
struct SearchResponse: Codable {
  let results: [Players]
}
let example = Players(status:200, data:  dataexample)
class ItunesDataFetcher: ObservableObject {
    @Published var items : Players = example
    @Published var showError = false
    @Published  var isRequestInProgress = false
    var error: Error? {
        willSet {
            DispatchQueue.main.async {
                self.showError = newValue != nil
            }
        }
    }
    enum FetchError: Error {
        case invalidURL
    }
  func fetchData(name: String,tag:String) {
        let urlString = "https://api.henrikdev.xyz/valorant/v1/account/\(name)/\(tag)"
        guard let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlstring)
              else {
                  error = FetchError.invalidURL
                  return
        }
        URLSession.shared.dataTask(with: url) { data, response, error  in
            defer {
              DispatchQueue.main.async {
              self.isRequestInProgress = false
              }
            }
            if let data=data {
                do {
                    let searchResponse = try JSONDecoder().decode(Players.self, from: data)
                    DispatchQueue.main.async {
                        self.items = searchResponse.self
                        self.error = nil
                    }
                } catch  {
                    self.error = error
                }
            } else if let error = error {
                self.error = error
            }
        }.resume()
        
    }
}
func convertDateTime(timeValue: Int) -> String {
    let truncatedTime = Int(timeValue)
    let date = Date(timeIntervalSince1970: TimeInterval(truncatedTime))
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "GMT+8")
    formatter.dateFormat = "yyyy/MM/dd/ hh:mm a"

    return formatter.string(from: date)
}
struct news: Codable{
    let status: Int
    let data: [Datum]
}
// MARK: - Datum
struct Datum: Codable{
    let bannerURL: String
    let category: String
    let date: String
    let externalLink: String? 
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case bannerURL = "banner_url"
        case category, date
        case externalLink = "external_link"
        case title, url
    }
}



