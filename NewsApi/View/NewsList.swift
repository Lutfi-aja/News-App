//
//  NewsList.swift
//  NewsApi
//
//  Created by Upi on 20/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsList: View {
    @ObservedObject var newsViewModel = NewsViewModel()
    var body: some View {
        NavigationView{
            List(newsViewModel.data) {item in
                NavigationLink(destination: NewsDetail(news: item)) {
                    HStack{
                        //jika gambarnya ada
                        if item.image != "" {
                            WebImage(url: URL(string: item.image)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 170)
                                .background(Image("loader")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width:60, height: 30))
                                .cornerRadius(10)
                        }else {
                            Image("loader")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 170)
                                .cornerRadius(10)
                        }
                        VStack {
                            Text(item.title).fontWeight(.bold)
                            Text(item.description).font(.caption)
                                .lineLimit(3)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("all"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList()
    }
}
