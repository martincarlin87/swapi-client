//
//  CharacterView.swift
//  swapi-client
//
//  Created by Martin Carlin on 02/06/2020.
//  Copyright © 2020 Martin Carlin. All rights reserved.
//

import SwiftUI

struct CharacterView: View {
    
    var character: Character?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(character?.name ?? "").font(.title)
            
            HStack(alignment: .top) {
                Text("Height: \(character?.height ?? "") cm").font(.subheadline)
                
                Spacer()
                
                Text("Birth Year: \(character?.birth_year ?? "")").font(.subheadline)
            }
        }
        .padding()
        // .onAppear(perform: loadMovies)
        
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
    }
}
