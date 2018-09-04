//
//  PokemonController.swift
//  PokeDeck
//
//  Created by Levi Linchenko on 04/09/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class PokemonController {
    
    static let shared = PokemonController()
    
    private init() {}
    
    //        URL: https://pokeapi.co/api/v2/pokemon/802/
    let baseURL = URL(string: "https://pokeapi.co/api/v2")

    func fetchPokemon(by pokemonName: String, completion: @escaping (Pokemon?) -> Void) {
        
        guard let url = baseURL else {print("💩 URL"); return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let requestURL = url.appendingPathComponent("pokemon").appendingPathComponent(pokemonName)
            URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
                
                defer {completion(nil)}
                do {
                    
                    if let error = error {throw error}
                    
                    guard let data = data else {throw NSError() }
                    
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(pokemon)
                    
                } catch let error {
                        print("💩Error fetching pokemon, \(error)")
                        return
                    
                }
        }.resume()
        
    }
    
    func fetchImage(pokemon: Pokemon, completion: @escaping (UIImage?) -> Void){
        
        let imageURL = pokemon.spritesDictionary.image
        
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            defer{completion(nil)}
            do{
                if let error = error {throw error}
                guard let data = data else {throw NSError()}
                
//                let image = try pokemon.spritesDictionary.image
                guard let image = UIImage(data: data) else {return}
                completion(image)
                
            } catch let error {
                print("error fetching image\(error)\(error.localizedDescription)")
                return
            }
            
            
        }.resume()
        
    }
    
}
