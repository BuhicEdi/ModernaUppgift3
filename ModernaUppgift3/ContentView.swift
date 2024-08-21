//
//  ContentView.swift
//  ModernaUppgift3
//
//  Created by Edi Buhic on 2024-08-21.
//

import SwiftUI

struct ContentView: View {
    @State private var kanyeQuote: String = "..."
    
    
    var body: some View {
        VStack {
            Text("Kanye West once said")
                .bold()
                .font(.system(size: 25))
                .padding(30)
            
            Text(kanyeQuote)
                .multilineTextAlignment(.center)

        }
        .onAppear(perform: getQuote)
    }


func getQuote() {
    guard let apiURL = URL(string: "https://api.kanye.rest") else { return }
    
    URLSession.shared.dataTask(with: apiURL) { data, response, error in
        if let data = data {
            if let decodedResponse = try? JSONDecoder().decode(QuoteData.self, from: data) {
                DispatchQueue.main.async {
                    self.kanyeQuote = "\"\(decodedResponse.quote)\" "
                    }
                }
            }
        } .resume()
    }
}
    
    struct QuoteData: Codable {
        let quote: String
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
