//
//  NewsViewModel.swift
//  NewsApi
//
//  Created by Upi on 20/04/21.
//

import Foundation
import SwiftyJSON

class NewsViewModel: ObservableObject {
    @Published var data = [News]()
    
    init() {
        let url = "https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=36e6033904b24a13ad597a190f0c3064" //pengambilan API

        let session = URLSession(configuration: .default) //langkah ke 2
        session.dataTask(with: URL(string: url)!) { (data, _, error) in //tiga respon utama pada dataTask  //langkah ke 3
            if error != nil{
                print((error?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            let items = json["articles"].array!
            
            for i in items {
                let title = i["title"].stringValue
                let image = i["urlToImage"].stringValue
                let description = i["description"].stringValue
                
                DispatchQueue.main.async {
                    self.data.append(News(title: title, image: image, description: description))
                }
            }
        }.resume() //langkah 4 (terakhir)
    }
}
