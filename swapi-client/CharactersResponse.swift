//
//  CharactersResponse.swift
//  swapi-client
//
//  Created by Martin Carlin on 02/06/2020.
//  Copyright © 2020 Martin Carlin. All rights reserved.
//

import Foundation

struct CharactersResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Character]
}
