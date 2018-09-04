//
//  Pokemon.swift
//  PokeDeck
//
//  Created by Levi Linchenko on 04/09/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import Foundation


struct Pokemon: Decodable {
    let abilities: [AbilitiesDictionary]
    let name: String
    let id: Int
    let spritesDictionary: SpritesDictionary
    
    private enum CodingKeys: String, CodingKey {
        case abilities
        case name
        case id
        case spritesDictionary = "sprites"
    }
    
    var abilitiesName: [String] {
        return abilities.compactMap({$0.ability.name} )
    }
    
    struct AbilitiesDictionary: Decodable{
        let ability: Ability
        struct Ability: Decodable{
            let name: String
        }
    }
}



struct SpritesDictionary: Decodable{
    let image: URL
    
    private enum CodingKeys: String, CodingKey {
        case image = "front_default"
    }
}
