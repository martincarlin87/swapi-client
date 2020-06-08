//
//  ContentView.swift
//  swapi-client
//
//  Created by Martin Carlin on 02/06/2020.
//  Copyright © 2020 Martin Carlin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var characters: [Character] = []
    @State private var page = 1;
    @State private var count = 0;
    @State private var hideLoadMore = false
    @State private var showAlert = false

    var body: some View {
        
        NavigationView {
            
            
            VStack {
                
                List {
                    
                    Section(header: Text("Characters")) {
                        
                        ForEach(characters, id: \.self) { character in
                        
                            NavigationLink(destination: CharacterView(character: character)) {
                                Text(character.name)
                            }
                        }
                    }
                }
                .onAppear{
                    // only load the first page, otherwise this is called every time the CharacterView is shown
                    // and we go come back to this view
                    if self.page == 1 {
                        self.loadCharacters()
                    }
                }
            }
            .navigationBarTitle("Swapi Api Client", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.loadCharacters()
                }) {
                    Text("Load More")
                }
                .opacity(self.hideLoadMore ? 0 : 1)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("All characters loaded!"), message: Text("There are no more characters to show!"), dismissButton: .default(Text("Got it!")))
                }
            
            )
            .listStyle(GroupedListStyle())
            
        }
        
    }
    
    private func loadCharacters() {
        
        // don't load any more if we are already at the limit
        if (self.count > 0 && self.characters.count >= self.count) {
            
            print("No more to load")
            
            self.hideLoadMore = true
            self.showAlert = true
            
            return
        }
        
        let charactersURL = URL(string: "https://swapi.dev/api/people/?page=\(self.page)")!
        
        let url = charactersURL
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                
                if let charactersResponse = try? JSONDecoder().decode(CharactersResponse.self, from: data) {
                    
                    // keep track of how many results there are
                    self.count = charactersResponse.count
                    
                    // increase the page number for the next request
                    self.page = self.page + 1
                    
                    DispatchQueue.main.async {
                        print(charactersResponse.results)
                        
                        withAnimation {
                            self.characters.append(contentsOf: charactersResponse.results)
                        }
                    }

                    return
                }
            }

            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
