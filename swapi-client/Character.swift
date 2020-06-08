//
//  Character.swift
//  swapi-client
//
//  Created by Martin Carlin on 02/06/2020.
//  Copyright © 2020 Martin Carlin. All rights reserved.
//

import Foundation

struct Character: Decodable, Hashable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles : [String]
    let starships: [String]
    let created: String
    let edited: String
    let url: String
}
