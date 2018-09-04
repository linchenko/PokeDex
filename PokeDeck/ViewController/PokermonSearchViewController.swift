//
//  PokermonSearchViewController.swift
//  PokeDeck
//
//  Created by Levi Linchenko on 04/09/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class PokermonSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var IDOutlet: UILabel!
    @IBOutlet weak var abilitiesOutlet: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarOutlet.delegate = self
        
        
    }
    
    func pickPokemon(pokemonName: String){
        
        imageOutlet.image = #imageLiteral(resourceName: "pokemonBall")
        imageOutlet.spin()
        
        
        PokemonController.shared.fetchPokemon(by: pokemonName) { (pokemon) in
            guard let pokemon = pokemon else {return}
            DispatchQueue.main.async {
                
                self.nameOutlet.text = pokemon.name.capitalized
                self.IDOutlet.text = "\(String(pokemon.id))"
                self.abilitiesOutlet.text = "Abilities: \(pokemon.abilitiesName.joined(separator: ", "))"
                
            }
            PokemonController.shared.fetchImage(pokemon: pokemon, completion: { (image) in
                DispatchQueue.main.async {
                    if image != nil {
                        self.imageOutlet.layer.removeAllAnimations()
                        self.imageOutlet.image = image
                        
                    } else {
                        return
                    }
                }
            })
        }
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        let id = Int(arc4random_uniform(802))
        pickPokemon(pokemonName: "\(id + 1)")
    }
    
    
    
    
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let pokemonText = searchBar.text?.lowercased() else {return}
        pickPokemon(pokemonName: pokemonText)
        searchBar.resignFirstResponder()
    }
    
    
    

    
    
}



extension UIImageView {
    func spin() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 0.25 // or however long you want ...
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        DispatchQueue.main.async {
            self.layer.add(rotation, forKey: "rotationAnimation")
        }
    }
}







